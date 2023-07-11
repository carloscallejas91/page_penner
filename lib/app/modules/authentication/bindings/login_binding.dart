import "package:get/get.dart";
import "package:page_penner/app/modules/authentication/controllers/login_controller.dart";

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
