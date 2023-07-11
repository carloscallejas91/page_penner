import "package:get/get.dart";
import "package:page_penner/app/modules/authentication/controllers/new_account_controller.dart";

class NewAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NewAccountController());
  }
}
