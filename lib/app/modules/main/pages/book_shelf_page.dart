import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:page_penner/app/modules/main/controllers/main_controller.dart';
import 'package:page_penner/app/modules/main/widgets/book_item_model_alt.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      controller.toReadList.length.toString(),
                      "Aguardando leitura",
                    ),
                    const Text("|").onPrimary(context).opacity(.3),
                    itemDetail(
                      context,
                      controller.inReadingList.length.toString(),
                      "Em leitura",
                    ),
                    const Text("|").onPrimary(context).opacity(.3),
                    itemDetail(
                      context,
                      controller.finishedList.length.toString(),
                      "Concluídos",
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
                          final VolumeInformation book = controller.resultBookShelfList[index];
                          return BookItemModelAlt(
                            book: book,
                            publishedDate: controller.handlePublicationDate(book.publishedDate),
                            description: controller.parseHtmlString(book.description ?? ""),
                            pageCount: controller.handleNumberOfPages(book.pageCount),
                            onTap: () {
                              controller.goToBookInformation(book: book, isFavorite: false, isMyBook: true);
                            },
                          );
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
