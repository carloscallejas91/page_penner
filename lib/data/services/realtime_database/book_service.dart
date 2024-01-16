import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:page_penner/data/models/volume_information.dart';

class BookService {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference databaseReference;

  Future<(String?, bool)> uploadBook({
    required String path,
    required VolumeInformation request,
  }) async {
    String? error;
    late bool result;

    databaseReference = database.ref(path);

    await databaseReference.set(request.toJson()).then((_) {
      result = true;
    }).catchError((e) {
      error = e;
      result = false;
    });

    return (error, result);
  }

  Future<(String?, bool)> removeBook({
    required String path,
    required String id,
  }) async {
    String? error;
    late bool result;

    databaseReference = database.ref(path);

    final reference = await databaseReference.child(id).once();
    if (reference.snapshot.exists) {
      await databaseReference.child(id).remove().then((value) {
        result = true;
      }).catchError((e) {
        error = e;
        result = false;
      });
    } else {
      error = "Não foi possível encontrar o livro.";
      result = false;
    }

    return (error, result);
  }

  Future<RxList<VolumeInformation>> getBooks({
    required String path,
  }) async {
    final RxList<VolumeInformation> object = <VolumeInformation>[].obs;

    databaseReference = database.ref(path);
    final DataSnapshot snapshot = await databaseReference.get();

    if (snapshot.exists) {
      final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      // final List<VolumeInformation> fetchedBooks = [];

      data.forEach((key, value) {
        object.add(VolumeInformation.fromJson(value as Map<dynamic, dynamic>));
      });
    } else {
      object.value = [];
    }

    return object;
  }
}
