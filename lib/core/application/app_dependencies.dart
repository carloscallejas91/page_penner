import "package:get/get.dart";
import "package:page_penner/integrations/firebase/firebase_integration.dart";

mixin AppDependencies {
  static void initialize() {}

  static Future<void> initializeAsync() async {
    // Integration
    await Get.putAsync(() => FirebaseIntegration().init());
  }
}
