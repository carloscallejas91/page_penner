import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:page_penner/app/modules/home/controllers/home_controller.dart";
import "package:page_penner/app/modules/home/widgets/book_avatar_widget.dart";
import "package:page_penner/app/modules/home/widgets/profile_header_widget.dart";
import "package:page_penner/app/widgets/circular_progress_indicator/cc_progress_indicator.dart";
import "package:page_penner/core/extensions/text_extension.dart";
import "package:page_penner/core/values/strings.dart";
import "package:page_penner/data/api/response/book_search_response.dart";

class HomeWidget extends GetView<HomeController> {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft,
      child: Obx(
        () => Visibility(
          visible: controller.loaded.value == true,
          replacement: const CCProgressIndicator(
            message: "Aguarde enquanto concluímos seu cadastro...",
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProfileHeaderWidget(
                userName: controller.userName!,
                photoUrl: controller.photoUrlStorage,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: Obx(
                          () => Visibility(
                            visible: controller.booksLoaded.value,
                            replacement: const CCProgressIndicator(),
                            child: controller.bookList.isNotEmpty
                                ? ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(width: 8),
                                    itemCount: controller.bookList.length,
                                    itemBuilder: (context, index) {
                                      return bookResultsItemModel(
                                          context, controller.bookList[index]);
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
                      TextField(
                        controller: controller.searchController,
                        keyboardType: TextInputType.emailAddress,
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
                            onPressed: controller.booksLoaded.value
                                ? controller.cleanFilter
                                : null,
                          ),
                        ),
                        onChanged: (text) {
                          controller.filterChanged(text);
                        },
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
                      Obx(
                        () => controller.wishList.value.isNotEmpty
                            ? SizedBox(
                                height: 250,
                                child: Obx(
                                  () => ListView.separated(
                                    itemCount: controller.wishList.value.length,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(width: 16);
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () {
                                            controller
                                                .goToBookInformationWishlist(
                                                    controller.wishList[index]);
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 125,
                                                height: 190,
                                                child: BookAvatarWidget(
                                                  urlImageNotFound:
                                                      notFoundImageVariant,
                                                  bookUrl: controller
                                                      .getImageUrl(controller
                                                          .wishList[index]),
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              SizedBox(
                                                width: 125,
                                                height: 40,
                                                child: Text(controller
                                                        .wishList[index]
                                                        .itemInformation!
                                                        .title!)
                                                    .titleSmall()
                                                    .setTextAlign(
                                                      TextAlign.center,
                                                    )
                                                    .setMaxLines(2)
                                                    .setOverflow(
                                                      TextOverflow.ellipsis,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Container(
                                width: double.infinity,
                                height: 220,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: AssetImage(wishlistResultNotFound),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
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

  Container bookResultsItemModel(BuildContext context, Book book) {
    return Container(
      width: MediaQuery.of(context).size.width * .80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage(cardBookImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            controller.goToBookInformation(book.selfLink!);
          },
          child: Row(
            children: [
              Container(
                width: 128,
                height: double.infinity,
                padding: const EdgeInsets.all(4),
                child: BookAvatarWidget(
                  bookUrl: book.volumeInformation!.imageLinks?.smallThumbnail,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        book.volumeInformation!.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ).titleMedium().onPrimary(context),
                      Text(
                        book.volumeInformation!.authors!.toList().join(", "),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ).bodySmall().primaryContainer(context),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text("Páginas: ")
                              .bodySmall()
                              .onPrimary(context)
                              .bold(),
                          Text(
                            controller.handleNumberOfPages(
                              book.volumeInformation!.pageCount,
                            ),
                          ).bodySmall().primaryContainer(context),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Publicado em: ")
                              .bodySmall()
                              .onPrimary(context)
                              .bold(),
                          Text(
                            controller.handlePublicationDate(
                              book.volumeInformation!.publishedDate,
                            ),
                          ).bodySmall().primaryContainer(context),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        book.volumeInformation!.description ??
                            "Descrição incompleta...",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ).bodySmall().primaryContainer(context),
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

// Widget profileImageWidget({required BuildContext context}) {
//   return controller.photoUrlStorage != null
//       ? CircleAvatar(
//           radius: 32,
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           child: CircleAvatar(
//             radius: 30.0,
//             backgroundImage: NetworkImage(controller.photoUrlStorage!),
//             backgroundColor: Colors.transparent,
//           ),
//         )
//       : CircleAvatar(
//           backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
//           radius: 30,
//           child: Icon(
//             Icons.camera_alt_outlined,
//             color: Theme.of(context).colorScheme.onSurfaceVariant,
//           ),
//         );
// }

// Widget bookImageWidget({required Book book}) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(20.0),
//     child: book.volumeInfo!.imageLinks?.smallThumbnail != null
//         ? Image.network(
//             book.volumeInfo!.imageLinks!.thumbnail!,
//             fit: BoxFit.cover,
//           )
//         : Image.asset(
//             notFoundImage,
//             fit: BoxFit.cover,
//           ),
//   );
// }
}
