import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:page_penner/app/widgets/dialog/cc_dialog.dart";
import "package:page_penner/app/widgets/snack_bar/cc_snack_bar.dart";
import "package:page_penner/data/api/books_api.dart";
import "package:page_penner/data/models/volume_information.dart";
import "package:page_penner/data/services/auth/auth_service.dart";
import "package:page_penner/data/services/realtime_database/book_service.dart";
import "package:page_penner/data/services/realtime_database/request/book_request.dart";
import "package:page_penner/data/services/realtime_database/response/book_list_response.dart";
import "package:url_launcher/url_launcher.dart";
import "package:uuid/uuid.dart";

class BookInformationController extends GetxController {
  // Services
  final AuthService _authService = AuthService();
  final BookService _wishlistService = BookService();

  // API
  final BooksApi booksApi = BooksApi();

  // User
  late final User? _user;

  // Model
  Rx<BookListResponse> myBookItem = BookListResponse().obs;

  // Strings
  late final String urlBook;
  late final String bookId;

  // Conditions
  RxBool loadedScreen = false.obs;
  bool fromUrl = true;
  RxBool myWishlist = false.obs;
  RxBool myBook = false.obs;

  @override
  void onInit() {
    initializeVariables();
    _getUserInfo();
    super.onInit();
  }

  void initializeVariables() {
    fromUrl = Get.arguments[0] as bool;
    if (fromUrl == true) {
      urlBook = Get.arguments[1] as String;
      bookId = const Uuid().v1();
      getBookInformation();
    } else {
      myBookItem.value = Get.arguments[1] as BookListResponse;
      bookId = myBookItem.value.id!;
      myWishlist.value = true;
      loadedScreen.value = true;
    }
  }

  Future<void> _getUserInfo() async {
    _user = await _authService.userIsLoggedIn();
  }

  Future<void> getBookInformation() async {
    loadedScreen.value = false;
    await booksApi.getBook(urlBook).then((value) {
      myBookItem.value = _convertInBookItem(value.volumeInformation!);
    }).catchError((e) {
      CCSnackBar.error(
          message: "Ocorreu um erro ao tentar recuperar a lista de livros: $e");
    }).whenComplete(() => loadedScreen.value = true);
  }

  Future<void> pressedMoreInfo(String uri) async {
    await launchUrl(Uri.parse(uri)).then((value) {
      if (!value) {
        CCSnackBar.error(
            message:
                "Não foi possível acessar a url neste momento. Por favor tente novamente mais tarde.");
      }
    }).catchError((e) {
      CCSnackBar.error(
          message:
              "Não foi possível acessar a url neste momento. Por favor tente novamente mais tarde.");
    });
  }

  void alertAddOrRemoveWishlist(
      BuildContext context, bool value, BookListResponse book) {
    if (value == true) {
      CCDialog.dialogNeutralAndPositiveButton(
        context: context,
        title: "Lista de desejos",
        contentText:
            "Deseja remover ${book.itemInformation!.title} da sua lista de desejos?",
        onPressedNeutralButton: Get.back,
        nameNeutralButton: "Não",
        onPressedPositiveButton: pressPositiveButtonToRemoveWishlist,
        namePositiveButton: "Sim",
        colorPositiveButton: Theme.of(context).colorScheme.error,
      );
    } else {
      CCDialog.dialogNeutralAndPositiveButton(
        context: context,
        title: "Lista de desejos",
        contentText:
            "Deseja adicionar ${book.itemInformation!.title} na sua lista de desejos?",
        onPressedNeutralButton: Get.back,
        nameNeutralButton: "Não",
        onPressedPositiveButton: pressPositiveButtonToAddWishlist,
        namePositiveButton: "Sim",
      );
    }
  }

  void alertAddOrRemoveBookShelf(
      BuildContext context, bool value, BookListResponse book) {
    if (value == true) {
      CCDialog.dialogNeutralAndPositiveButton(
        context: context,
        title: "Estante de livros",
        contentText:
            "Deseja remover ${book.itemInformation!.title} da sua estante de livros?",
        onPressedNeutralButton: Get.back,
        nameNeutralButton: "Não",
        onPressedPositiveButton: pressPositiveButtonToRemoveBookShelf,
        namePositiveButton: "Sim",
        colorPositiveButton: Theme.of(context).colorScheme.error,
      );
    } else {
      CCDialog.dialogNeutralAndPositiveButton(
        context: context,
        title: "Estante de livros",
        contentText:
            "Deseja adicionar ${book.itemInformation!.title} na sua estante de livros?",
        onPressedNeutralButton: Get.back,
        nameNeutralButton: "Não",
        onPressedPositiveButton: pressPositiveButtonToAddBookShelf,
        namePositiveButton: "Sim",
      );
    }
  }

  Future<void> pressPositiveButtonToAddWishlist() async {
    Get.back();

    switch (myBook.value) {
      case true:
        if (await removeBookshelf()) {
          myBook.value = false;
          myWishlist.value = await addWishlist();
        } else {
          CCSnackBar.error(message: "Ocorreu um erro! Tente novamente.");
        }
      case false:
        myWishlist.value = await addWishlist();
    }
  }

  Future<void> pressPositiveButtonToRemoveWishlist() async {
    Get.back();

    if (await removeWishlist()) {
      myWishlist.value = false;
    }
  }

  Future<void> pressPositiveButtonToAddBookShelf() async {
    Get.back();

    switch (myWishlist.value) {
      case true:
        if (await removeWishlist()) {
          myWishlist.value = false;
          myBook.value = await addBookshelf();
        } else {
          CCSnackBar.error(message: "Ocorreu um erro! Tente novamente.");
        }
      case false:
        myBook.value = await addBookshelf();
    }
  }

  Future<void> pressPositiveButtonToRemoveBookShelf() async {
    Get.back();

    if (await removeBookshelf()) {
      myBook.value = false;
    }
  }

  Future<bool> addWishlist() async {
    final request = _createBookRequest(myBookItem.value.itemInformation!);
    bool result = false;
    await _wishlistService
        .addBook(
            path: "users/${_user!.uid}/wish_list/$bookId", request: request)
        .then((value) {
      result = value.$2;
    });

    return result;
  }

  Future<bool> removeWishlist() async {
    bool result = false;
    await _wishlistService
        .removeBook(path: "users/${_user!.uid}/wish_list/", id: bookId)
        .then((value) {
      result = value.$2;
    });
    return result;
  }

  Future<bool> addBookshelf() async {
    final request = _createBookRequest(myBookItem.value.itemInformation!);
    bool result = false;
    await _wishlistService
        .addBook(
            path: "users/${_user!.uid}/book_shelf/$bookId", request: request)
        .then((value) {
      result = value.$2;
    });
    return result;
  }

  Future<bool> removeBookshelf() async {
    bool result = false;
    await _wishlistService
        .removeBook(path: "users/${_user!.uid}/book_shelf/", id: bookId)
        .then((value) {
      result = value.$2;
    });
    return result;
  }

  BookListResponse _convertInBookItem(VolumeInformation item) {
    return BookListResponse(
      itemInformation: VolumeInformation(
        title: item.title,
        authors: item.authors,
        publisher: item.publisher,
        publishedDate: item.publishedDate,
        pageCount: item.pageCount,
        description: item.description,
        imageLinks: item.imageLinks,
        previewLink: item.previewLink,
        infoLink: item.infoLink,
      ),
    );
  }

  BookRequest _createBookRequest(VolumeInformation item) {
    return BookRequest(
      volumeInformation: VolumeInformation(
        title: item.title,
        authors: item.authors,
        publisher: item.publisher,
        publishedDate: item.publishedDate,
        pageCount: item.pageCount,
        description: item.description,
        imageLinks: item.imageLinks,
        previewLink: item.previewLink,
        infoLink: item.infoLink,
      ),
    );
  }

  void goToHome() {
    Get.offAllNamed("/home", arguments: [
      false,
      _user,
    ]);
  }
}
