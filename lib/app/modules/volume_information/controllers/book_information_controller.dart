import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:html/parser.dart';
import "package:page_penner/app/widgets/dialog/cc_dialog.dart";
import "package:page_penner/app/widgets/snack_bar/cc_snack_bar.dart";
import "package:page_penner/data/api/books_api.dart";
import "package:page_penner/data/models/volume_information.dart";
import "package:page_penner/data/services/realtime_database/book_service.dart";
import "package:page_penner/routes/app_routes.dart";
import 'package:url_launcher/url_launcher.dart';
import "package:uuid/uuid.dart";

class BookInformationController extends GetxController {
  // Services
  final BookService _bookService = BookService();

  // API
  final BooksApi booksApi = BooksApi();

  // User
  late final User user;

  // Model
  late Rx<VolumeInformation> book = VolumeInformation().getDefaultValue().obs;

  // Controller
  TextEditingController annotationsController = TextEditingController();

  // Conditions
  RxBool loaded = false.obs;
  RxBool isFavorite = false.obs;
  RxBool isMyBook = false.obs;
  RxBool toRead = false.obs;
  RxBool finishedReading = false.obs;
  RxBool displayAnnotations = false.obs;
  RxBool editingAnnotations = false.obs;

  // Skin
  RxInt footerSkin = 1.obs;

  // Strings
  String? currentStatus;
  String? currentAnnotations;
  late final String urlBook;
  late final String uuid;

  @override
  Future<void> onInit() async {
    _initializeVariables();
    super.onInit();
  }

  //-> Iniciar variaveis <--/
  Future<void> _initializeVariables() async {
    final bool favorite = Get.arguments[2] as bool;
    final bool myBook = Get.arguments[3] as bool;
    user = Get.arguments[0] as User;
    if (favorite) {
      book.value = Get.arguments[1] as VolumeInformation;
      uuid = book.value.id!;
      isFavorite.value = Get.arguments[2] as bool;
      loaded.value = true;
    } else if (myBook) {
      book.value = Get.arguments[1] as VolumeInformation;
      currentAnnotations = book.value.myAnnotations;
      currentStatus = book.value.status;
      uuid = book.value.id!;
      isMyBook.value = Get.arguments[3] as bool;

      if (book.value.status == "Aguardando leitura") {
        toRead.value = true;
        finishedReading.value = false;
      }

      if (book.value.status == "Leitura concluída") {
        finishedReading.value = true;
        toRead.value = false;
      }

      footerSkin.value = 2;
      loaded.value = true;
    } else {
      urlBook = Get.arguments[1] as String;
      uuid = const Uuid().v1();
      await _getBookInformation();
    }
  }

  //--> Retira as tag HTML <--//
  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  //-> Recuperar informações do livro através da API <--/
  Future<void> _getBookInformation() async {
    loaded.value = false;
    await booksApi.getBook(urlBook).then((value) {
      currentStatus = "Lista de desejo";
      book.value = _volumeInformationModel(id: uuid, item: value.volumeInformation!, status: "Lista de desejo");
    }).catchError((e) {
      CCSnackBar.error(message: "Ocorreu um erro ao tentar recuperar a lista de livros: $e");
    }).whenComplete(() => loaded.value = true);
  }

  //-> Encontrar url de imagem válida para exibir como capa <--/
  String? getImageUrl(VolumeInformation book) {
    return book.imageLinks?.extraLarge ??
        book.imageLinks?.medium ??
        book.imageLinks?.thumbnail ??
        book.imageLinks?.small ??
        book.imageLinks?.smallThumbnail;
  }

  //-> Botão para adicionar ou remover livro da lista de favoritos <--/
  Future<void> wishListButton() async {
    switch (isMyBook.value) {
      case true:
        await removeBookFromShelf().then((value) async {
          if (value == true) {
            isMyBook.value = false;
            await uploadBookToWishList().then((value) {
              if (value == true) {
                isFavorite.value = true;
              }
            });
          }
        });
      case false:
        await uploadBookToWishList().then((value) {
          if (value == true) {
            isFavorite.value = true;
          }
        });
    }
  }

  //-> Botão para adicionar ou remover livro da estante <--/
  Future<void> bookShelfButton() async {
    switch (isFavorite.value) {
      case true:
        await removeBookFromWishlist().then((value) async {
          if (value == true) {
            isFavorite.value = false;
            await uploadBookToShelf().then((value) {
              if (value == true) {
                isMyBook.value = true;
              }
            });
          }
        });
      case false:
        await uploadBookToShelf().then((value) {
          if (value == true) {
            isMyBook.value = true;
          }
        });
    }
  }

  //-> Botão para adicionar ou remover livro da lista de 'Aguardando leitura' <--/
  Future<void> changeStackOfBooksStatusButton() async {
    switch (toRead.value) {
      case true:
        await changeBookStatus("Livro na estante").then((value) async {
          if (value == true) {
            toRead.value = false;
          }
        });
      case false:
        await changeBookStatus("Aguardando leitura").then((value) {
          if (value == true) {
            toRead.value = true;
            finishedReading.value = false;
          }
        });
    }
  }

  //-> Botão para adicionar ou remover livro da lista de 'Finalizados' <--/
  Future<void> changeFinishedBooksStatusButton() async {
    switch (finishedReading.value) {
      case true:
        await changeBookStatus("Livro na estante").then((value) async {
          if (value == true) {
            finishedReading.value = false;
          }
        });
      case false:
        await changeBookStatus("Leitura concluída").then((value) {
          if (value == true) {
            finishedReading.value = true;
            toRead.value = false;
            // isFavorite.value = true;
          }
        });
    }
  }

  //-> Botão que permite visualizar mais informações sobre o livro <--/
  Future<void> moreInformationButton(String uri) async {
    await launchUrl(Uri.parse(uri)).then((value) {
      if (!value) CCSnackBar.error(message: "Não foi possível acessar a url neste momento. Por favor tente novamente mais tarde.");
    }).catchError((e) {
      CCSnackBar.error(message: "Não foi possível acessar a url neste momento. Por favor tente novamente mais tarde.");
    });
  }

  //-> Modal para adicionar ou remover livro da lista de desejos <--/
  void displayWishListAlert(BuildContext context, bool favorite, VolumeInformation book) {
    if (favorite == true) {
      CCDialog.dialogNeutralAndPositiveButton(
        context: context,
        title: "Lista de desejos",
        contentText: "Deseja remover '${book.title}' da sua lista de desejos?",
        onPressedNeutralButton: Get.back,
        nameNeutralButton: "Não",
        onPressedPositiveButton: () async {
          Get.back();
          await removeBookFromWishlist().then((value) {
            if (value == true) isFavorite.value = false;
          });
        },
        namePositiveButton: "Remover",
        colorPositiveButton: Theme.of(context).colorScheme.error,
      );
    } else {
      CCDialog.dialogNeutralAndPositiveButton(
        context: context,
        title: "Lista de desejos",
        contentText: "Deseja adicionar '${book.title}' na sua lista de desejos?",
        onPressedNeutralButton: Get.back,
        nameNeutralButton: "Não",
        onPressedPositiveButton: () async {
          Get.back();
          await wishListButton();
        },
        namePositiveButton: "Adicionar",
      );
    }
  }

  //-> Modal para adicionar ou remover livro da estante <--/
  void displayAlertBookShelf(BuildContext context, bool value, VolumeInformation book) {
    if (value == true) {
      CCDialog.dialogNeutralAndPositiveButton(
        context: context,
        title: "Estante de livros",
        contentText: "Deseja remover '${book.title}' da sua estante de livros?",
        onPressedNeutralButton: Get.back,
        nameNeutralButton: "Não",
        onPressedPositiveButton: () async {
          Get.back();
          await removeBookFromShelf().then((value) {
            if (value == true) isMyBook.value = false;
          });
        },
        namePositiveButton: "Remover",
        colorPositiveButton: Theme.of(context).colorScheme.error,
      );
    } else {
      CCDialog.dialogNeutralAndPositiveButton(
        context: context,
        title: "Estante de livros",
        contentText: "Deseja adicionar '${book.title}' na sua estante de livros?",
        onPressedNeutralButton: Get.back,
        nameNeutralButton: "Não",
        onPressedPositiveButton: () async {
          Get.back();
          await bookShelfButton();
        },
        namePositiveButton: "Adicionar",
      );
    }
  }

  //-> Modal para adicionar ou remover livro da lista de desejos <--/
  void displayReadBookAlert(BuildContext context, bool bookIsOpen, VolumeInformation book) {
    if (bookIsOpen == true) {
      CCDialog.dialogNeutralAndPositiveButton(
        context: context,
        title: "Pilha de livros",
        contentText: "Remover '${book.title}' da fila de leitura?",
        onPressedNeutralButton: Get.back,
        nameNeutralButton: "Não",
        onPressedPositiveButton: () async {
          Get.back();
          await changeStackOfBooksStatusButton();
        },
        namePositiveButton: "Remover",
        colorPositiveButton: Theme.of(context).colorScheme.error,
      );
    } else {
      CCDialog.dialogNeutralAndPositiveButton(
        context: context,
        title: "Pilha de livros",
        contentText: "Adicionar '${book.title}' na fila de leitura?",
        onPressedNeutralButton: Get.back,
        nameNeutralButton: "Não",
        onPressedPositiveButton: () async {
          Get.back();
          await changeStackOfBooksStatusButton();
        },
        namePositiveButton: "Adicionar",
      );
    }
  }

  //-> Modal para adicionar ou remover livro da lista de finalizados <--/
  void finishedReadingBookAlert(BuildContext context, bool finishedBook, VolumeInformation book) {
    if (finishedBook == true) {
      CCDialog.dialogNeutralAndPositiveButton(
        context: context,
        title: "${book.title}",
        contentText: "Gostaria de retirar este livro da lista de leituras concluídas?",
        onPressedNeutralButton: Get.back,
        nameNeutralButton: "Não",
        onPressedPositiveButton: () async {
          Get.back();
          await changeFinishedBooksStatusButton();
        },
        namePositiveButton: "Remover",
        colorPositiveButton: Theme.of(context).colorScheme.error,
      );
    } else {
      CCDialog.dialogNeutralAndPositiveButton(
        context: context,
        title: "${book.title}",
        contentText: "Gostaria de adicionar este livro na lista de leituras concluídas?",
        onPressedNeutralButton: Get.back,
        nameNeutralButton: "Não",
        onPressedPositiveButton: () async {
          Get.back();
          await changeFinishedBooksStatusButton();
        },
        namePositiveButton: "Adicionar",
      );
    }
  }

  //-> Adicionar um livro na estante <--/
  Future<bool> uploadBookToShelf() async {
    final request = _volumeInformationModel(id: uuid, item: book.value, status: "Livro na estante");
    bool result = false;
    await _bookService.uploadBook(path: "users/${user.uid}/book_shelf/list/$uuid", request: request).then((value) {
      currentStatus = "Livro na estante";
      result = value.$2;
    }).catchError((e) {
      CCSnackBar.error(message: "Ocorreu um erro ao tentar adicionar o livro na sua estante.");
    });
    return result;
  }

  //-> Remover um livro na estante <--/
  Future<bool> removeBookFromShelf() async {
    bool result = false;
    await _bookService.removeBook(path: "users/${user.uid}/book_shelf/list", id: uuid).then((value) {
      result = value.$2;
    }).catchError((e) {
      CCSnackBar.error(message: "Ocorreu um erro ao tentar remover o livro da estante.");
    });
    return result;
  }

  //-> Mudar o status do livro <--/
  Future<bool> changeBookStatus(String status) async {
    bool result = false;
    final request = _volumeInformationModel(id: uuid, item: book.value, status: status);

    await _bookService.uploadBook(path: "users/${user.uid}/book_shelf/list/$uuid", request: request).then((value) {
      currentStatus = status;
      result = value.$2;
    }).catchError((e) {
      CCSnackBar.error(message: "Ocorreu um erro ao tentar adicionar o livro na lista de favoritos.");
    });

    return result;
  }

  //-> Adicionar um livro na lista de desejos <--/
  Future<bool> uploadBookToWishList() async {
    bool result = false;
    final request = _volumeInformationModel(id: uuid, item: book.value, status: "Lista de desejo");

    await _bookService.uploadBook(path: "users/${user.uid}/wish_list/list/$uuid", request: request).then((value) {
      result = value.$2;
    }).catchError((e) {
      CCSnackBar.error(message: "Ocorreu um erro ao tentar adicionar o livro na lista de favoritos.");
    });

    return result;
  }

  //-> Remover um livro na lista de desejos <--/
  Future<bool> removeBookFromWishlist() async {
    bool result = false;
    await _bookService.removeBook(path: "users/${user.uid}/wish_list/list", id: uuid).then((value) {
      result = value.$2;
    }).catchError((e) {
      CCSnackBar.error(message: "Ocorreu um erro ao tentar remover o livro na lista de favoritos.");
    });
    return result;
  }

  //-> Preencher modelo <--/
  VolumeInformation _volumeInformationModel({required String id, required VolumeInformation item, String? status, String? annotations}) {
    return VolumeInformation(
      id: id,
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
      status: status ?? currentStatus,
      myAnnotations: annotations ?? currentAnnotations ?? "Sem anotações...",
    );
  }

  void showAnnotations() {
    displayAnnotations.value = true;
  }

  void editAnnotations(VolumeInformation book) {
    editingAnnotations.value = true;

    annotationsController.text = currentAnnotations!;
  }

  Future<void> saveAnnotations(VolumeInformation item) async {
    final request = _volumeInformationModel(id: uuid, item: item, status: currentStatus, annotations: annotationsController.text);

    await _bookService.uploadBook(path: "users/${user.uid}/book_shelf/list/$uuid", request: request).then((value) {
      currentAnnotations = annotationsController.text;
      editingAnnotations.value = false;
      CCSnackBar.success(message: "Anotações salvas com sucesso.");
    }).catchError((e) {
      CCSnackBar.error(message: "Ocorreu um erro ao tentar salvar sua anotação");
    });
  }

  //--> Rotas <--//
  void goToMain() {
    if (isFavorite.value) {
      Get.offAllNamed(Routes.MAIN, arguments: [user, 0]);
    } else if (isMyBook.value) {
      Get.offAllNamed(Routes.MAIN, arguments: [user, 1]);
    } else {
      Get.offAllNamed(Routes.MAIN, arguments: [user, 0]);
    }
  }
}
