import "package:get/get.dart";
import "package:page_penner/app/modules/authentication/controllers/splash_screen_controller.dart";

class SplashScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController());
  }
}
