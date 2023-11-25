import "package:get/get.dart";
import "package:page_penner/core/rest/rest_http.dart";
import "package:page_penner/integrations/firebase/firebase_integration.dart";

mixin AppDependencies {
  static void initialize() {
    Get.lazyPut(() => RestHttp(), fenix: true);
  }

  static Future<void> initializeAsync() async {
    // Integration
    await Get.putAsync(() => FirebaseIntegration().init());
  }
}
