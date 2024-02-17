import "package:eva_icons_flutter/eva_icons_flutter.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:page_penner/app/modules/main/widgets/book_avatar_widget.dart";
import "package:page_penner/app/modules/volume_information/controllers/book_information_controller.dart";
import "package:page_penner/app/widgets/button/cc_elevated_button.dart";
import "package:page_penner/app/widgets/button/cc_text_button.dart";
import "package:page_penner/app/widgets/circular_progress_indicator/cc_progress_indicator.dart";
import "package:page_penner/core/extensions/text_extension.dart";
import "package:page_penner/core/utils/date_manager_utils.dart";
import "package:page_penner/core/values/strings.dart";
import "package:page_penner/data/models/volume_information.dart";

class BookInformationView extends GetView<BookInformationController> {
  const BookInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(onPressed: () => controller.goToMain()),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundAboutBook),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(
          () => SafeArea(
            child: Visibility(
              visible: controller.loaded.value && controller.displayAnnotations.value == false,
              replacement: controller.displayAnnotations.value ? _myAnnotations(controller.book.value) : const CCProgressIndicator(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.height * .20,
                          child: BookAvatarWidget(
                            bookUrl: controller.getImageUrl(controller.book.value),
                            hasShadow: true,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          controller.book.value.title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ).titleMedium().primary(context).center(),
                        Text(
                          controller.book.value.authors!.toList().join(", "),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ).bodySmall().center(),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _itemDetail(
                                context,
                                controller.book.value.pageCount.toString(),
                                "Número de Páginas",
                              ),
                              const Text("|").onPrimary(context).opacity(.3),
                              _itemDetail(
                                context,
                                DateManagerUtils.formatDate("${controller.book.value.publishedDate}"),
                                "Data de Publicação",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 4, color: Theme.of(context).colorScheme.primary),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Theme.of(context).colorScheme.inverseSurface,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Sobre o livro").titleMedium().secondaryContainer(context),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.star,
                                          size: 12,
                                          color: Theme.of(context).colorScheme.tertiaryContainer,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(controller.book.value.rating!).titleMedium().secondaryContainer(context),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Visibility(
                                      visible: controller.isMyBook.value,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.sticky_note_2,
                                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                                        ),
                                        onPressed: () => controller.showAnnotations(),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    IconButton(
                                      icon: Icon(
                                        Icons.share,
                                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              controller.parseHtmlString(controller.book.value.description ?? "Descrição incompleta..."),
                              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  controller.footerSkin.value == 1 ? _defaultSkin(context) : _myBookSkin(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _defaultSkin(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).colorScheme.inverseSurface,
        child: Row(
          children: [
            Expanded(
              flex: 0,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: IconButton(
                  icon: Obx(
                    () => Icon(
                      controller.isFavorite.value ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                  onPressed: () {
                    controller.displayWishListAlert(context, controller.isFavorite.value, controller.book.value);
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 0,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: IconButton(
                  icon: Obx(
                    () => Icon(
                      controller.isMyBook.value ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                  onPressed: () {
                    controller.displayAlertBookShelf(context, controller.isMyBook.value, controller.book.value);
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: CCElevatedButton(
                buttonColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
                textButton: "Informações ",
                icon: FontAwesomeIcons.arrowRightLong,
                onPressed: () {
                  controller.moreInformationButton(controller.book.value.infoLink.toString());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _myBookSkin(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).colorScheme.inverseSurface,
        child: Row(
          children: [
            Expanded(
              flex: 0,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: IconButton(
                  icon: Obx(
                    () => Icon(
                      controller.isMyBook.value ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                  onPressed: () {
                    controller.displayAlertBookShelf(context, controller.isMyBook.value, controller.book.value);
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 0,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: IconButton(
                  icon: Obx(
                    () => Icon(
                      controller.toRead.value ? FontAwesomeIcons.bookOpen : EvaIcons.bookOpenOutline,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                  onPressed: () {
                    //displayReadBookAlert
                    controller.displayReadBookAlert(context, controller.toRead.value, controller.book.value);
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 0,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: IconButton(
                  icon: Obx(
                    () => Icon(
                      controller.finishedReading.value ? EvaIcons.book : EvaIcons.bookOutline,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                  onPressed: () {
                    controller.finishedReadingBookAlert(context, controller.finishedReading.value, controller.book.value);
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: CCElevatedButton(
                buttonColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
                textButton: "Informações ",
                icon: FontAwesomeIcons.arrowRightLong,
                onPressed: () {
                  controller.moreInformationButton(controller.book.value.infoLink.toString());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _itemDetail(BuildContext context, String value, String label) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Text(value).titleMedium().onPrimary(context),
          Text(label).bodySmall().onPrimary(context).center(),
        ],
      ),
    );
  }

  Widget _myAnnotations(VolumeInformation book) {
    return Column(
      children: [
        Container(height: 4, color: Theme.of(Get.context!).colorScheme.primary),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(Get.context!).colorScheme.inverseSurface,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Minhas anotações").titleMedium().secondaryContainer(Get.context!),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit_note,
                              color: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
                            ),
                            onPressed: () => controller.editAnnotations(book),
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
                            ),
                            onPressed: () => controller.displayAnnotations.value = false,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: controller.editingAnnotations.value,
                    replacement: Text(
                      controller.currentAnnotations ?? "Sem anotações"
                    ).onPrimary(Get.context!),
                    child: Column(
                      children: [
                        TextField(
                          controller: controller.annotationsController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(color: Theme.of(Get.context!).colorScheme.onInverseSurface),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CCTextButton(
                              text: "Cancelar".toUpperCase(),
                              textColor: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
                              onPressed: () => controller.editingAnnotations.value = false,
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 200,
                              child: CCElevatedButton(
                                textButton: "Salvar",
                                buttonColor: Theme.of(Get.context!).colorScheme.primary,
                                textColor: Theme.of(Get.context!).colorScheme.onPrimary,
                                onPressed: () => controller.saveAnnotations(book),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
