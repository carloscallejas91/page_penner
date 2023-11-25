import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:page_penner/app/modules/home/controllers/home_controller.dart";
import "package:page_penner/app/modules/home/widgets/book_avatar_widget.dart";
import "package:page_penner/app/modules/home/widgets/profile_header_widget.dart";
import "package:page_penner/core/extensions/text_extension.dart";

class BookShelfWidget extends GetView<HomeController> {
  const BookShelfWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          ProfileHeaderWidget(
            userName: controller.userName!,
            photoUrl: controller.photoUrlStorage,
          ),
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
                itemDetail(
                  context,
                  "07",
                  "Qtd. de livros",
                ),
                const Text("|").onPrimary(context).opacity(.3),
                itemDetail(
                  context,
                  "03",
                  "Livros lidos",
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Row(
              children: [
                const SizedBox(
                  width: 125,
                  height: 200,
                  child: BookAvatarWidget(
                    bookUrl: null,
                    hasShadow: false,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Harry Potter e a pedra filosofal",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ).titleMedium().primary(context),
                            Text(
                              ["Autor 01, Autor 02, Autor 03"]
                                  .toList()
                                  .join(", "),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ).bodySmall().onBackground(context),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.file,
                                        size: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiaryContainer,
                                      ),
                                      const SizedBox(width: 4),
                                      const Text("120")
                                          .bodySmall()
                                          .onPrimary(context),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.star,
                                          size: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiaryContainer,
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          FontAwesomeIcons.star,
                                          size: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiaryContainer,
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          FontAwesomeIcons.star,
                                          size: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiaryContainer,
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          FontAwesomeIcons.star,
                                          size: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiaryContainer,
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          FontAwesomeIcons.starHalf,
                                          size: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiaryContainer,
                                        ),
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
        ],
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
