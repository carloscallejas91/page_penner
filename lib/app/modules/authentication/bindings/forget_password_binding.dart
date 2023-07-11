import "package:get/get.dart";
import "package:page_penner/app/modules/authentication/controllers/forget_password_controller.dart";

class ForgetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ForgetPasswordController());
  }
}
