import "dart:io";

import "package:firebase_storage/firebase_storage.dart";

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final Reference storageRef = FirebaseStorage.instance.ref();

  Future<(String?, String)> uploadPicture({
    required String path,
    required String reference,
    required String name,
  }) async {
    String? urlDownload;
    late String message;
    final File file = File(path);

    final SettableMetadata metadata =
        SettableMetadata(contentType: "image/jpeg");

    final UploadTask uploadTask =
        storageRef.child("$reference/$name").putFile(file, metadata);

    await uploadTask.then((p0) async {
      if (p0.state == TaskState.success) {
        urlDownload = await (await uploadTask).ref.getDownloadURL();
        message = "Envio da imagem realizado com sucesso.";
      } else {
        message = "Erro ao realizao o envio da imagem.";
      }
    });

    return (urlDownload, message);
  }
}
