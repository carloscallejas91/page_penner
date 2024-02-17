import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_penner/app/modules/main/controllers/main_controller.dart';
import 'package:page_penner/app/modules/main/widgets/book_item_model_alt.dart';
import 'package:page_penner/app/widgets/circular_progress_indicator/cc_progress_indicator.dart';
import 'package:page_penner/core/extensions/text_extension.dart';
import 'package:page_penner/data/models/volume_information.dart';
import 'package:unicons/unicons.dart';

class FinishedReadingPage extends GetView<MainController> {
  const FinishedReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Visibility(
        visible: controller.bookShelfLoaded.value,
        replacement: const CCProgressIndicator(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    "Livros concluídos",
                  ).titleMedium().primary(context).bold(),
                  const SizedBox(width: 8),
                  Icon(
                    UniconsLine.book,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: controller.finishedList.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsets.all(16),
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
                      itemCount: controller.finishedList.length,
                      itemBuilder: (context, index) {
                        final VolumeInformation book = controller.finishedList[index];
                        return BookItemModelAlt(
                          book: book,
                          publishedDate: controller.handlePublicationDate(book.publishedDate),
                          description: controller.parseHtmlString(book.description ?? ""),
                          pageCount: controller.handleNumberOfPages(book.pageCount),
                          onTap: () => controller.goToBookInformation(book: book, isFavorite: false, isMyBook: true),
                        );
                      },
                    )
                  : const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            "Nenhum livro concluído.",
                            textAlign: TextAlign.center,
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
}
