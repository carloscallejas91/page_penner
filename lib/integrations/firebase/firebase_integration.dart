import "package:firebase_core/firebase_core.dart";
import "package:page_penner/firebase_options.dart";

class FirebaseIntegration {
  Future<FirebaseIntegration> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return this;
  }
}
