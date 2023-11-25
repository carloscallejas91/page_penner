import "package:get/get.dart";
import "package:page_penner/app/modules/volume_information/controllers/book_information_controller.dart";

class BookInformationWishListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BookInformationController());
  }
}
