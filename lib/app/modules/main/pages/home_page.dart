import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:page_penner/app/modules/main/controllers/main_controller.dart';
import 'package:page_penner/app/modules/main/widgets/book_avatar_widget.dart';
import 'package:page_penner/app/widgets/circular_progress_indicator/cc_progress_indicator.dart';
import 'package:page_penner/core/extensions/text_extension.dart';
import 'package:page_penner/core/values/strings.dart';
import 'package:page_penner/data/api/response/book_search_response.dart';

class HomePage extends GetView<MainController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Obx(
                () => Visibility(
                  visible: controller.booksLoaded.value,
                  replacement: const Center(child: CCProgressIndicator()),
                  child: controller.bookList.isNotEmpty
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
                          itemCount: controller.bookList.length,
                          itemBuilder: (context, index) {
                            return _bookResultsItemModel(context, controller.bookList[index]);
                          },
                        )
                      : Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage(resultNotFound),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => TextField(
                controller: controller.searchController,
                keyboardType: TextInputType.text,
                enabled: controller.booksLoaded.value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: "Pesquise por livros",
                  hintText: "Ex: Harry Potter, A Cabana, etc",
                  prefixIcon: const Icon(
                    FontAwesomeIcons.magnifyingGlass,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(FontAwesomeIcons.xmark),
                    onPressed: controller.booksLoaded.value ? controller.cleanHomeFilter : null,
                  ),
                ),
                onChanged: (text) {
                  controller.filterChanged(text);
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  "Lista de desejos",
                ).titleMedium().primary(context).bold(),
                const SizedBox(width: 8),
                Icon(
                  FontAwesomeIcons.heart,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: Obx(
                () => Visibility(
                  visible: controller.wishListLoaded.value,
                  replacement: const Center(child: CCProgressIndicator()),
                  child: controller.wishList.isNotEmpty
                      ? ListView.separated(
                          itemCount: controller.wishList.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 16);
                          },
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return _wishListResultsItemModel(index);
                          },
                        )
                      : const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Atualmente, não há nenhum livro presente na sua lista de desejos.",
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

  Material _wishListResultsItemModel(int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          controller.goToBookInformation(book: controller.wishList[index], isFavorite: true, isMyBook: false);
        },
        child: Column(
          children: [
            SizedBox(
              width: 125,
              height: 190,
              child: BookAvatarWidget(
                urlImageNotFound: notFoundImageVariant,
                bookUrl: controller.getImageUrl(controller.wishList[index]),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 125,
              height: 40,
              child: Text(controller.wishList[index].title!)
                  .titleSmall()
                  .setTextAlign(TextAlign.center)
                  .setMaxLines(2)
                  .setOverflow(TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
