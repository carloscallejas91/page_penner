import 'package:flutter/material.dart';

class AboutBookWidget extends StatelessWidget {
  //   final RxBool loaded;
//   final Rx<BookListResponse> book;
//   final RxBool myWishlist;
//   final RxBool myBook;
//   final Function(BuildContext, bool, BookListResponse) addOrRemoveWishlist;
//   final Function(BuildContext, bool, BookListResponse) addOrRemoveBookShelf;
//   final Function(String) moreInfo;

  const AboutBookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}

// import "package:flutter/material.dart";
// import "package:flutter_html/flutter_html.dart";
// import "package:font_awesome_flutter/font_awesome_flutter.dart";
// import "package:get/get.dart";
// import "package:page_penner/app/modules/home/widgets/book_avatar_widget.dart";
// import "package:page_penner/app/widgets/button/cc_elevated_button.dart";
// import "package:page_penner/app/widgets/circular_progress_indicator/cc_progress_indicator.dart";
// import "package:page_penner/core/extensions/text_extension.dart";
// import "package:page_penner/core/utils/date_manager_utils.dart";
// import "package:page_penner/core/values/strings.dart";
// import "package:page_penner/data/services/realtime_database/response/book_list_response.dart";
//
// class AboutBookWidget extends StatelessWidget {
//   final RxBool loaded;
//   final Rx<BookListResponse> book;
//   final RxBool myWishlist;
//   final RxBool myBook;
//   final Function(BuildContext, bool, BookListResponse) addOrRemoveWishlist;
//   final Function(BuildContext, bool, BookListResponse) addOrRemoveBookShelf;
//   final Function(String) moreInfo;
//
//   const AboutBookWidget({
//     super.key,
//     required this.loaded,
//     required this.book,
//     required this.myWishlist,
//     required this.myBook,
//     required this.addOrRemoveWishlist,
//     required this.addOrRemoveBookShelf,
//     required this.moreInfo,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         leading: const BackButton(),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(backgroundAboutBook),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SafeArea(
//           child: Obx(
//             () => Visibility(
//               visible: loaded.value,
//               replacement: const CCProgressIndicator(),
//               child: Obx(
//                 () => Column(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             top: 0, right: 32, bottom: 32, left: 32),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               width: MediaQuery.of(context).size.height * .20,
//                               child: BookAvatarWidget(
//                                 // todo: criar função para pegar uma das imagens
//                                 bookUrl: getImageUrl(book.value),
//                                 hasShadow: true,
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             Text(
//                               book.value.itemInformation?.title ?? "",
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ).titleMedium().primary(context).center(),
//                             Text(
//                               book.value.itemInformation?.authors!
//                                       .toList()
//                                       .join(", ") ??
//                                   "",
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ).bodySmall().center(),
//                             const SizedBox(height: 16),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 16),
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context).colorScheme.primary,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   itemDetail(
//                                     context,
//                                     "${book.value.itemInformation?.pageCount}",
//                                     "Número de Páginas",
//                                   ),
//                                   const Text("|")
//                                       .onPrimary(context)
//                                       .opacity(.3),
//                                   itemDetail(
//                                     context,
//                                     DateManagerUtils.formatDate(
//                                         "${book.value.itemInformation?.publishedDate}"),
//                                     "Data de Publicação",
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 4,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         width: double.infinity,
//                         color: Theme.of(context).colorScheme.inverseSurface,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 16, right: 16, bottom: 8, left: 16),
//                               child: const Text("Sobre o livro")
//                                   .titleMedium()
//                                   .primaryContainer(context),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: Scrollbar(
//                                 thumbVisibility: true,
//                                 trackVisibility: true,
//                                 child: SingleChildScrollView(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 0, horizontal: 8),
//                                   child: Html(
//                                     data: book.value.itemInformation
//                                             ?.description ??
//                                         "Descrição incompleta...",
//                                     style: {
//                                       "body": Style(
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .onPrimary,
//                                       ),
//                                       "p": Style(
//                                         margin: Margins.all(0),
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .onPrimary,
//                                       ),
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 8, right: 16, bottom: 8, left: 16),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 0,
//                                     child: CircleAvatar(
//                                       backgroundColor: Theme.of(context)
//                                           .colorScheme
//                                           .tertiary,
//                                       child: IconButton(
//                                         icon: Obx(
//                                           () => Icon(
//                                             myWishlist.value
//                                                 ? FontAwesomeIcons.solidHeart
//                                                 : FontAwesomeIcons.heart,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .tertiaryContainer,
//                                           ),
//                                         ),
//                                         onPressed: () {
//                                           addOrRemoveWishlist(context,
//                                               myWishlist.value, book.value);
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 16),
//                                   Expanded(
//                                     flex: 0,
//                                     child: CircleAvatar(
//                                       backgroundColor: Theme.of(context)
//                                           .colorScheme
//                                           .tertiary,
//                                       child: IconButton(
//                                         icon: Obx(
//                                               () => Icon(
//                                                 myBook.value
//                                                 ? FontAwesomeIcons.solidBookmark
//                                                 : FontAwesomeIcons.bookmark,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .tertiaryContainer,
//                                           ),
//                                         ),
//                                         onPressed: () {
//                                           addOrRemoveBookShelf(context,
//                                               myBook.value, book.value);
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 16),
//                                   Expanded(
//                                     flex: 1,
//                                     child: CCElevatedButton(
//                                       buttonColor:
//                                           Theme.of(context).colorScheme.primary,
//                                       textColor: Theme.of(context)
//                                           .colorScheme
//                                           .onPrimary,
//                                       textButton: "Mais informações",
//                                       icon: FontAwesomeIcons.arrowRightLong,
//                                       onPressed: () {
//                                         moreInfo(book
//                                             .value.itemInformation!.infoLink!);
//                                         // controller.moreInfo(controller
//                                         //     .book.volumeInfo!.infoLink!);
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Expanded itemDetail(BuildContext context, String value, String label) {
//     return Expanded(
//       flex: 1,
//       child: Column(
//         children: [
//           Text(value).titleMedium().onPrimary(context),
//           Text(label).bodySmall().onPrimary(context).center(),
//         ],
//       ),
//     );
//   }
//
//   String? getImageUrl(BookListResponse book) {
//     return book.itemInformation?.imageLinks?.extraLarge ??
//         book.itemInformation?.imageLinks?.medium ??
//         book.itemInformation?.imageLinks?.thumbnail ??
//         book.itemInformation?.imageLinks?.small ??
//         book.itemInformation?.imageLinks?.smallThumbnail;
//   }
// }
