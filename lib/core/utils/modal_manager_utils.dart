import "package:get/get.dart";

mixin ModalManagerUtils {
  static void closeModal() {
    while (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
