import "package:firebase_database/firebase_database.dart";
import "package:page_penner/data/services/realtime_database/request/user_profile_update_request.dart";

class UserProfileService {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference databaseReference;

  Future<(String?, bool)> updateProfileUser({
    required String path,
    required UserProfileUpdateRequest request,
  }) async {
    late String message;
    late bool result;

    databaseReference = database.ref(path);

    await databaseReference.set(request.toJson()).then((_) {
      message = "Registro atualizado com sucesso.";
      result = true;
    }).catchError((e) {
      message = "Ocorreu um erro! Tente novamente.";
      result = false;
    });

    return (message, result);
  }
}
