import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:page_penner/app/modules/main/controllers/main_controller.dart';
import 'package:page_penner/app/modules/main/widgets/book_avatar_widget.dart';
import 'package:page_penner/app/modules/main/widgets/book_item_model.dart';
import 'package:page_penner/app/widgets/circular_progress_indicator/cc_progress_indicator.dart';
import 'package:page_penner/core/extensions/text_extension.dart';
import 'package:page_penner/data/api/response/book_search_response.dart';
import 'package:unicons/unicons.dart';

class ToReadPage extends GetView<MainController> {
  const ToReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Fila de leitura",
                ).titleMedium().primary(context).bold(),
                const SizedBox(width: 8),
                Icon(
                  UniconsLine.books,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Obx(
                () => Visibility(
                  visible: controller.bookShelfLoaded.value,
                  replacement: const Center(child: CCProgressIndicator()),
                  child: controller.toReadList.isNotEmpty
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
                          itemCount: controller.toReadList.length,
                          itemBuilder: (context, index) {
                            final book = controller.toReadList[index];
                            return BookItemModel(
                              book: book,
                              publishedDate: controller.handlePublicationDate(book.publishedDate),
                              description: controller.parseHtmlString(book.description ?? ""),
                              pageCount: controller.handleNumberOfPages(book.pageCount),
                              listLength: controller.toReadList.length,
                              onTap: () {
                                controller.displayToReadAlert(book);
                              },
                            );
                          },
                        )
                      : const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Atualmente, não há nenhum livro presente na sua fila de leitura.",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const Text(
                  "Em leitura",
                ).titleMedium().primary(context).bold(),
                const SizedBox(width: 8),
                Icon(
                  UniconsLine.book_reader,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Obx(
                () => Visibility(
                  visible: controller.bookShelfLoaded.value,
                  replacement: const Center(child: CCProgressIndicator()),
                  child: controller.inReadingList.isNotEmpty
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
                          itemCount: controller.inReadingList.length,
                          itemBuilder: (context, index) {
                            final book = controller.inReadingList[index];
                            return BookItemModel(
                              book: book,
                              publishedDate: controller.handlePublicationDate(book.publishedDate),
                              description: controller.parseHtmlString(book.description ?? ""),
                              pageCount: controller.handleNumberOfPages(book.pageCount),
                              listLength: controller.inReadingList.length,
                              onTap: () {controller.displayInReadingAlert(book);},
                            );
                          },
                        )
                      : const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Você não está lendo nenhum livro.",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookResultsItemModel(BuildContext context, Book book) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          controller.goToBookInformation(urlBook: book.selfLink!, isFavorite: false, isMyBook: false);
        },
        child: Ink(
          width: MediaQuery.of(context).size.width * .85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 125,
                height: 200,
                child: BookAvatarWidget(
                  bookUrl: book.volumeInformation!.imageLinks?.smallThumbnail,
                  hasShadow: false,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.volumeInformation!.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ).titleMedium().primary(context),
                          Text(
                            book.volumeInformation!.authors!.toList().join(", "),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ).bodySmall().onBackground(context),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Publicado em: ").bodySmall().onBackground(context).bold(),
                          Text(
                            controller.handlePublicationDate(
                              book.volumeInformation!.publishedDate,
                            ),
                          ).bodySmall().onBackground(context),
                          const SizedBox(height: 4),
                          Text(
                            controller.parseHtmlString(book.volumeInformation!.description ?? ""),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ).bodySmall().onBackground(context),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.file,
                                      size: 12,
                                      color: Theme.of(context).colorScheme.tertiaryContainer,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      controller.handleNumberOfPages(
                                        book.volumeInformation!.pageCount,
                                      ),
                                    ).bodySmall().onPrimary(context),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.star,
                                        size: 12,
                                        color: Theme.of(context).colorScheme.tertiaryContainer,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(book.volumeInformation!.rating!.isEmpty || book.volumeInformation!.rating == "null"
                                              ? "S/A"
                                              : book.volumeInformation!.rating!)
                                          .bodySmall()
                                          .onPrimary(context),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
