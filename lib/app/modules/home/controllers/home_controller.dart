import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:page_penner/app/modules/home/widgets/book_shelf_widget.dart";
import "package:page_penner/app/modules/home/widgets/home_widget.dart";
import "package:page_penner/app/widgets/snack_bar/cc_snack_bar.dart";
import "package:page_penner/core/utils/date_manager_utils.dart";
import "package:page_penner/core/utils/debounce_utils.dart";
import "package:page_penner/data/api/books_api.dart";
import "package:page_penner/data/api/response/book_search_response.dart";
import "package:page_penner/data/services/auth/auth_service.dart";
import "package:page_penner/data/services/realtime_database/request/user_profile_update_request.dart";
import "package:page_penner/data/services/realtime_database/response/book_list_response.dart";
import "package:page_penner/data/services/realtime_database/user_profile_service.dart";
import "package:page_penner/data/services/realtime_database/book_service.dart";
import "package:page_penner/data/services/storage/storage_service.dart";

class HomeController extends GetxController {
  // services
  final AuthService _authService = AuthService();
  final UserProfileService _profileUserService = UserProfileService();
  final BookService _wishlistService = BookService();
  final StorageService _storageService = StorageService();

  // API
  final BooksApi booksApi = BooksApi();

  // Utils
  DebounceUtils debounce = DebounceUtils(milliseconds: 500);

  // Controller
  TextEditingController searchController = TextEditingController();

  // User
  late User _user;

  // Additional User Info
  String? userName;
  String? photoURL;
  String? photoUrlStorage;

  // Search Text
  String searchText = "";

  // Lists
  RxList<Book> bookList = <Book>[].obs;
  RxList<BookListResponse> wishList = <BookListResponse>[].obs;

  // Conditionals
  RxBool loaded = false.obs;
  bool? firstLogin;
  RxBool booksLoaded = false.obs;
  RxBool wishListLoaded = false.obs;

  // Index
  RxInt selectedIndex = 0.obs;

  List<Widget> widgetOptions = <Widget>[
    const HomeWidget(),
    const BookShelfWidget(),
    Text(
      'Search',
    ),
    Text(
      'Profile',
    ),
  ];

  @override
  void onInit() {
    // _authService.logout();
    isTheFirstLogin();
    searchBooks("");
    getWishList();

    super.onInit();
  }

  // TODO: porque está como future? Get arguments dá erro se vazio?
  Future<void> isTheFirstLogin() async {
    if (Get.arguments[0] == true) {
      firstLogin = Get.arguments[0] as bool;
      _user = Get.arguments[1] as User;
      userName = Get.arguments[2] as String;
      photoURL = Get.arguments[3] as String;
      completeRegistration();
    } else {
      getUserInfo();
    }
  }

  void getUserInfo() {
    _user = Get.arguments[1] as User;
    userName = _user.displayName;
    photoUrlStorage = _user.photoURL;
    loaded.value = true;
  }

  Future<void> completeRegistration() async {
    if (photoURL!.isNotEmpty) {
      await _uploadPhotoProfile();
    } else {
      await _addAdditionalUserInfo();
    }
  }

  Future<void> _uploadPhotoProfile() async {
    CCSnackBar.info(message: "Iniciando envio da foto de perfil...");
    _storageService
        .uploadPicture(
            path: photoURL!,
            reference: "images/user/${_user.uid}",
            name: DateTime.now().toIso8601String())
        .then((value) {
      if (value.$1 != null) {
        photoUrlStorage = value.$1;
        CCSnackBar.success(message: value.$2);
        _addAdditionalUserInfo();
      } else {
        CCSnackBar.error(message: value.$2);
      }
    });
  }

  Future<void> _addAdditionalUserInfo() async {
    CCSnackBar.info(
        message: "Atualizando informações na base de autenticação...");
    try {
      await _user.updateDisplayName(userName);
      await _user.updatePhotoURL(photoUrlStorage ?? "");
      await _user.reload();

      CCSnackBar.success(message: "Informações do perfil atualizada.");
      _updateProfile();
    } on FirebaseException catch (e) {
      CCSnackBar.error(message: "${e.message}");
    } catch (e) {
      CCSnackBar.error(
          message:
              "Ocorreu um erro ao tentar atualizar as informações adicionais. $e");
    }
  }

  Future<void> _updateProfile() async {
    CCSnackBar.info(
        message: "Concluindo registro de informações adicionais...");
    final request = _createProfileUpdateRequest();

    _profileUserService
        .updateProfileUser(path: "users/${_user.uid}", request: request)
        .then((value) {
      loaded.value = true;
      if (value.$2 == true) {
        CCSnackBar.success(message: "${value.$1}");
      } else {
        CCSnackBar.error(message: "${value.$1}");
      }
    });
  }

  UserProfileUpdateRequest _createProfileUpdateRequest() {
    final credential = FirebaseAuth.instance.currentUser;
    return UserProfileUpdateRequest(
      name: "${credential?.displayName}",
      email: "${credential?.email}",
      photoUrl: "${credential?.photoURL}",
      createIn: "${credential?.metadata.creationTime}",
      lastLogin: "${credential?.metadata.lastSignInTime}",
    );
  }

  Future<void> searchBooks(String text) async {
    booksLoaded.value = false;
    bookList.clear();
    await booksApi.getBooks(text).then((value) {
      final books = value.items!;
      for (final book in books) {
        if ((book.volumeInformation!.authors!.isNotEmpty) &&
            (book.volumeInformation!.title!.toLowerCase().contains("box") ==
                false) &&
            (book.volumeInformation!.title!.toLowerCase().contains("kit") ==
                false)) {
          bookList.add(book);
        }
      }
    }).catchError((e) {
      CCSnackBar.error(
          message: "Ocorreu um erro ao tentar recuperar a lista de livros: $e");
    }).whenComplete(() => booksLoaded.value = true);
  }

  void filterChanged(String text) {
    if (searchText != text) {
      debounce.run(() {
        searchText = text;
        searchBooks(searchText);
      });
    }
  }

  void cleanFilter() {
    searchController.text = "";
    searchText = "";
    searchBooks(searchText);
  }

  String handleNumberOfPages(int? pages) {
    if (pages == 0 || pages == null) {
      return "Indefinido";
    } else {
      return pages.toString();
    }
  }

  String handlePublicationDate(String? date) {
    if (date == null) {
      return "Indefinido";
    } else if (date.length < 10) {
      return "Indefinido";
    } else {
      return DateManagerUtils.formatDate(date);
    }
  }

  String formatDate(String date) {
    return DateFormat("dd-MM-yyyy").format(DateTime.parse(date));
  }

  String? getImageUrl(BookListResponse book) {
    return book.itemInformation?.imageLinks?.extraLarge ??
        book.itemInformation?.imageLinks?.medium ??
        book.itemInformation?.imageLinks?.thumbnail ??
        book.itemInformation?.imageLinks?.small ??
        book.itemInformation?.imageLinks?.smallThumbnail;
  }

  void getWishList() {
    wishList.value =
        _wishlistService.getBook(path: "users/${_user.uid}/wish_list/");
  }

  void goToBookInformation(String urlBook) {
    Get.toNamed("/book_information", arguments: [
      true,
      urlBook,
    ]);
  }

  void goToBookInformationWishlist(BookListResponse book) {
    Get.toNamed("/book_information", arguments: [
      false,
      book,
    ]);
  }
}
