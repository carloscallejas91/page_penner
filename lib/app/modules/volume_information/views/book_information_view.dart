import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:page_penner/app/modules/volume_information/controllers/book_information_controller.dart";
import "package:page_penner/app/modules/volume_information/widgets/about_book_widget.dart";

class BookInformationView extends GetView<BookInformationController> {
  const BookInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AboutBookWidget(
      loaded: controller.loadedScreen,
      book: controller.myBookItem,
      myWishlist: controller.myWishlist,
      myBook: controller.myBook,
      addOrRemoveWishlist: controller.alertAddOrRemoveWishlist,
      addOrRemoveBookShelf: controller.alertAddOrRemoveBookShelf,
      moreInfo: controller.pressedMoreInfo,
    );
  }
}
