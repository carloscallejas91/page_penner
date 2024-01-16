import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:page_penner/app/modules/main/controllers/main_controller.dart';
import 'package:page_penner/app/modules/main/widgets/book_avatar_widget.dart';
import 'package:page_penner/app/widgets/circular_progress_indicator/cc_progress_indicator.dart';
import 'package:page_penner/core/extensions/text_extension.dart';
import 'package:page_penner/data/models/volume_information.dart';

class BookShelfPage extends GetView<MainController> {
  const BookShelfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Obx(
        () => Visibility(
          visible: controller.bookShelfLoaded.value,
          replacement: const CCProgressIndicator(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    itemDetail(
                      context,
                      controller.bookShelfList.length.toString(),
                      "Qtd. de livros",
                    ),
                    const Text("|").onPrimary(context).opacity(.3),
                    itemDetail(
                      context,
                      controller.finishedList.length.toString(),
                      "Livros lidos",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(
                  () => TextField(
                    controller: controller.searchBookShelfController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: "Pesquise por livros",
                      prefixIcon: const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(FontAwesomeIcons.xmark),
                        onPressed: controller.bookShelfLoaded.value ? controller.cleanBookShelfFilter : null,
                      ),
                    ),
                    onChanged: (text) {
                      controller.filterBookShelfChanged(text);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                flex: 1,
                child: controller.resultBookShelfList.isNotEmpty
                    ? ListView.separated(
                        padding: const EdgeInsets.all(16),
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
                        itemCount: controller.resultBookShelfList.length,
                        itemBuilder: (context, index) {
                          return _bookResultsItemModel(context, controller.resultBookShelfList[index]);
                        },
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              controller.bookShelfList.isEmpty
                                  ? "Atualmente, não há nenhum livro presente na sua estante."
                                  : "Não há nenhum livro presente na sua estante com este nome.",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bookResultsItemModel(BuildContext context, VolumeInformation book) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          controller.goToBookInformation(book: book, isFavorite: false, isMyBook: true);
        },
        child: Ink(
          width: double.infinity,
          height: 200,
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
                  bookUrl: book.imageLinks?.smallThumbnail,
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
                            book.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ).titleMedium().primary(context),
                          Text(
                            book.authors!.toList().join(", "),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ).bodySmall().onBackground(context),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text("Status: ").bodySmall().onBackground(context).bold(),
                              Text("${book.status!}.").bodySmall().onBackground(context),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Publicado em: ").bodySmall().onBackground(context).bold(),
                              Text(
                                controller.handlePublicationDate(
                                  book.publishedDate,
                                ),
                              ).bodySmall().onBackground(context),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.parseHtmlString(book.description!),
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
                                        book.pageCount,
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
                                      Text(book.rating!).bodySmall().onPrimary(context),
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

  Expanded itemDetail(BuildContext context, String value, String label) {
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
}
