import "package:firebase_database/firebase_database.dart";
import "package:get/get.dart";
import "package:page_penner/data/services/realtime_database/request/book_request.dart";
import "package:page_penner/data/services/realtime_database/response/book_list_response.dart";

class BookService {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference databaseReference;

  Future<(String?, bool)> addBook({
    required String path,
    required BookRequest request,
  }) async {
    late String message;
    late bool result;

    databaseReference = database.ref(path);

    await databaseReference.set(request.toJson()).then((_) {
      message =
          "${request.volumeInformation!.title} foi adicionado em sua lista de desejos.";
      result = true;
    }).catchError((e) {
      message = "Ocorreu um erro! Tente novamente.";
      result = false;
    });

    return (message, result);
  }

  Future<(String?, bool)> removeBook({
    required String path,
    required String id,
  }) async {
    late String message;
    late bool result;

    databaseReference = database.ref(path);

    final snapshot = await databaseReference.child(id).once();
    if (snapshot.snapshot.exists) {
      await databaseReference.child(id).remove().then((value) {
        message = "O livro foi removido da sua lista de desejos.";
        result = true;
      });
    } else {
      message = "Ocorreu um erro! Tente novamente.";
      result = false;
    }

    return (message, result);
  }

  RxList<BookListResponse> getBook({
    required String path,
  }) {
    final RxList<BookListResponse> object = <BookListResponse>[].obs;

    databaseReference = database.ref(path);

    databaseReference.onValue.listen((event) {
      if (event.snapshot.exists) {
        final Map<dynamic, dynamic> data =
            event.snapshot.value! as Map<dynamic, dynamic>;

        final List<BookListResponse> fetchedBooks = [];

        data.forEach((key, value) {
          fetchedBooks.add(BookListResponse.fromJson(
              key as String, value as Map<dynamic, dynamic>));
        });

        object.value = fetchedBooks;
      } else {
        object.value = [];
      }
    });

    return object;
  }
}
