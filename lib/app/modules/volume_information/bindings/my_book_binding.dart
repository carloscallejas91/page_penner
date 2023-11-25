import "package:get/get.dart";
import "package:page_penner/app/modules/volume_information/controllers/my_book_controller.dart";

class MyBookBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MyBookController());
  }
}
