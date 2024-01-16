import "package:firebase_database/firebase_database.dart";
import "package:page_penner/data/services/realtime_database/request/profile_update_request.dart";

class ProfileService {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference databaseReference;

  Future<(String?, bool)> updateProfile({
    required String path,
    required ProfileUpdateRequest request,
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
}
