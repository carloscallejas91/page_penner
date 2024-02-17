import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:page_penner/app/modules/main/pages/book_shelf_page.dart';
import 'package:page_penner/app/modules/main/pages/finished_reading_page.dart';
import 'package:page_penner/app/modules/main/pages/home_page.dart';
import 'package:page_penner/app/modules/main/pages/to_read_page.dart';
import 'package:page_penner/app/widgets/dialog/cc_dialog.dart';
import 'package:page_penner/app/widgets/snack_bar/cc_snack_bar.dart';
import 'package:page_penner/core/utils/date_manager_utils.dart';
import 'package:page_penner/core/utils/debounce_utils.dart';
import 'package:page_penner/data/api/books_api.dart';
import 'package:page_penner/data/api/response/book_search_response.dart';
import 'package:page_penner/data/models/volume_information.dart';
import 'package:page_penner/data/services/realtime_database/book_service.dart';

class MainController extends GetxController {
  // Services
  final BookService _bookService = BookService();

  // API
  final BooksApi _booksApi = BooksApi();

  // User
  late final User user;

  // Utils
  DebounceUtils debounce = DebounceUtils(milliseconds: 500);

  // Controllers
  TextEditingController searchController = TextEditingController();
  TextEditingController searchBookShelfController = TextEditingController();

  // Lists
  RxList<Book> bookList = <Book>[].obs;
  RxList<VolumeInformation> wishList = <VolumeInformation>[].obs;
  RxList<VolumeInformation> bookShelfList = <VolumeInformation>[].obs;
  RxList<VolumeInformation> resultBookShelfList = <VolumeInformation>[].obs;
  RxList<VolumeInformation> toReadList = <VolumeInformation>[].obs;
  RxList<VolumeInformation> inReadingList = <VolumeInformation>[].obs;
  RxList<VolumeInformation> finishedList = <VolumeInformation>[].obs;

  // Conditionals
  RxBool booksLoaded = false.obs;
  RxBool wishListLoaded = false.obs;
  RxBool bookShelfLoaded = false.obs;

  // Search Text
  String searchText = "";
  String searchBookShelfText = "";

  // Index
  RxInt selectedIndex = 0.obs;

  List<Widget> widgetOptions = <Widget>[
    const HomePage(),
    const BookShelfPage(),
    const ToReadPage(),
    const FinishedReadingPage(),
  ];

  @override
  Future<void> onInit() async {
    _getIndexPage();
    _getCredential();
    await searchBooks("Guerra dos tronos");
    await getWishlistBooks();
    await getBookShelf();
    super.onInit();
  }

  //--> Funções básicas (Inicio) <--//
  //--> Recuperar credencial do usuário <--//
  void _getCredential() {
    user = Get.arguments[0] as User;
  }

  //--> Recuperar index da página <--//
  void _getIndexPage() {
    selectedIndex.value = Get.arguments[1] as int;
  }

  //--> Funções básicas (Fim) <--//

  //--> Funções da página home (Inicio) <--//
  //--> Busca livros na API <--//
  Future<void> searchBooks(String text) async {
    booksLoaded.value = false;
    bookList.clear();
    await _booksApi.getBooks(text).then((value) {
      final books = value.items!;
      for (final book in books) {
        if ((book.volumeInformation!.authors!.isNotEmpty) &&
            (book.volumeInformation?.imageLinks != null) &&
            (book.volumeInformation!.title!.toLowerCase().contains("box") == false) &&
            (book.volumeInformation!.title!.toLowerCase().contains("kit") == false)) {
          bookList.add(book);
        }
      }
    }).catchError((e) {
      CCSnackBar.error(message: "Ocorreu um erro ao tentar recuperar a lista de livros: $e");
    }).whenComplete(() => booksLoaded.value = true);
  }

  //--> Realiza pesquisa ao notar alteração no campo de pesquisa <--//
  void filterChanged(String text) {
    if (searchText != text) {
      debounce.run(() {
        searchText = text;
        searchBooks(searchText);
      });
    }
  }

  //--> Limpar filtro de pesquisa - Home <--//
  void cleanHomeFilter() {
    searchController.text = "";
    searchText = "";
    searchBooks(searchText);
  }

  //--> Requisição ao firebase para recuperar lista de desejos <--//
  Future<void> getWishlistBooks() async {
    wishListLoaded.value = false;
    await _bookService.getBooks(path: "users/${user.uid}/wish_list/list").then((value) {
      wishList.value = value;
      wishListLoaded.value = true;
    }).catchError((e) {
      wishListLoaded.value = true;
      CCSnackBar.error(message: "Ocorreu um erro! Tente novamente.");
    });
  }

  //--> Funções da página home (Home) <--//

  //--> Funções da página Book Shelf (Inicio) <--//
  //--> Requisição ao firebase para recuperar lista de livros na estante <--//
  Future<void> getBookShelf() async {
    bookShelfLoaded.value = false;
    bookShelfList.clear();
    resultBookShelfList.clear();
    finishedList.clear();
    toReadList.clear();
    inReadingList.clear();
    await _bookService.getBooks(path: "users/${user.uid}/book_shelf/list").then((value) {
      bookShelfList.value = value;
      resultBookShelfList.value = value;

      distributeBooks();

      bookShelfLoaded.value = true;
    }).catchError((e) {
      bookShelfLoaded.value = true;
      CCSnackBar.error(message: "Ocorreu um erro! Tente novamente.");
    });
  }

  //--> Realiza pesquisa ao notar alteração no campo de pesquisa <--//
  void filterBookShelfChanged(String text) {
    searchBookShelfText = text;
    List<VolumeInformation> result = <VolumeInformation>[];
    for (var element in bookShelfList) {
      if (element.title!.toLowerCase().contains(searchBookShelfText.toLowerCase())) {
        result.add(element);
      }
    }
    resultBookShelfList.value = result;
  }

  //--> Limpar filtro de pesquisa - BookShelf <--//
  void cleanBookShelfFilter() {
    searchBookShelfController.text = "";
    searchBookShelfText = "";
    getBookShelf();
  }

  //--> Distribuir livros para as listas <--//
  void distributeBooks() {
    for (var book in bookShelfList) {
      if (book.status == "Leitura concluída") {
        finishedList.add(book);
      } else if (book.status == "Aguardando leitura") {
        toReadList.add(book);
      } else if (book.status == "Em leitura") {
        inReadingList.add(book);
      }
    }
  }

  //--> Retira as tag HTML <--//
  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  //--> Funções da página Book Shelf (fim) <--//

  //--> Funções da página To Read (Inicio) <--//
  void displayToReadAlert(VolumeInformation book) {
    CCDialog.dialogNeutralAndPositiveButton(
      context: Get.context!,
      title: "Iniciar leitura",
      contentText: "Deseja iniciar leitura do livro?",
      onPressedNeutralButton: Get.back,
      nameNeutralButton: "Não",
      onPressedPositiveButton: () async {
        Get.back();
        await changeToReadBooksStatus(book, "Em leitura");
      },
      namePositiveButton: "Iniciar",
    );
  }

  void displayInReadingAlert(VolumeInformation book) {
    CCDialog.dialogNeutralNegativeAndPositiveButton(
      context: Get.context!,
      title: "Em leitura",
      contentText: "O que deseja fazer com o livro '${book.title}'?",
      onPressedNeutralButton: Get.back,
      nameNeutralButton: "Cancelar",
      onPressedNegativeButton: () async {
        Get.back();
        await changeToReadBooksStatus(book, "Aguardando leitura");
      },
      nameNegativeButton: "Fila de leitura",
      onPressedPositiveButton: () async {
        Get.back();
        await changeToReadBooksStatus(book, "Leitura concluída");
      },
      namePositiveButton: "Concluír livro",
    );
  }

  Future<void> changeToReadBooksStatus(VolumeInformation book, String status) async {
    await changeBookStatus(book, status).then((value) async {
      if (value == true) {
        await getBookShelf();
      }
    });
  }

  //-> Mudar o status do livro <--/
  Future<bool> changeBookStatus(VolumeInformation book, String status) async {
    bool result = false;
    final request = _volumeInformationModel(book, status);

    await _bookService.uploadBook(path: "users/${user.uid}/book_shelf/list/${book.id}", request: request).then((value) {
      result = value.$2;
    }).catchError((e) {
      CCSnackBar.error(message: "Ocorreu um erro ao alterar o status do livro.");
    });

    return result;
  }

  //-> Preencher modelo <--/
  VolumeInformation _volumeInformationModel(VolumeInformation item, String status) {
    return VolumeInformation(
      id: item.id,
      title: item.title,
      authors: item.authors,
      publisher: item.publisher,
      publishedDate: item.publishedDate,
      pageCount: item.pageCount,
      description: item.description,
      imageLinks: item.imageLinks,
      previewLink: item.previewLink,
      infoLink: item.infoLink,
      rating: item.rating!.isEmpty || item.rating == "null" ? "S/A" : item.rating,
      status: status, // Livro na estante, Em leitura, Leitura Finalizada
      myAnnotations: item.myAnnotations
    );
  }

  //--> Funções da página To Read (Fim) <--//

  //--> Funções para tratar informações do livro (Início) <--//
  //--> Ajusta o número de páginas para um formato válido <--//
  String handleNumberOfPages(int? pages) {
    if (pages == 0 || pages == null) {
      return "Indefinido";
    } else {
      return pages.toString();
    }
  }

  //--> Ajusta a data de publicação para um formato válido <--//
  String handlePublicationDate(String? date) {
    if (date == null) {
      return "Indefinido";
    } else if (date.length < 10) {
      return "Indefinido";
    } else {
      return DateManagerUtils.formatDate(date);
    }
  }

  //-> Encontrar url de imagem válida para exibir como capa <--/
  String? getImageUrl(VolumeInformation book) {
    return book.imageLinks?.extraLarge ??
        book.imageLinks?.medium ??
        book.imageLinks?.thumbnail ??
        book.imageLinks?.small ??
        book.imageLinks?.smallThumbnail;
  }

  //--> Funções para tratar informações do livro (Fim) <--//

  //--> Funções usadas no header (Inicio) <--//
  //--> Gerar label de saudação <--//
  String generateLabel() {
    final hour = DateTime.now().hour;
    if (hour > 5 && hour <= 13) {
      return "Olá, bom dia!";
    } else if (hour > 13 && hour <= 18) {
      return "Olá, boa tarde!";
    } else {
      return "Olá, boa noite!";
    }
  }

//--> Funções usadas no header (Fim) <--//

  //--> Rotas (Inicio) <--//
  void goToBookInformation({String? urlBook, VolumeInformation? book, required bool isFavorite, required bool isMyBook}) {
    if (isFavorite || isMyBook) {
      Get.offAllNamed("/book_information", arguments: [user, book, isFavorite, isMyBook]);
    } else {
      Get.offAllNamed("/book_information", arguments: [user, urlBook, isFavorite, isMyBook]);
    }
  }
//--> Rotas (Fim) <--//
}
