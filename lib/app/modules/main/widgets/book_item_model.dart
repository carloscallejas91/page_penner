import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_penner/app/modules/main/widgets/book_avatar_widget.dart';
import 'package:page_penner/core/extensions/text_extension.dart';
import 'package:page_penner/data/models/volume_information.dart';

class BookItemModel extends StatelessWidget {
  final VolumeInformation book;
  final String publishedDate;
  final String description;
  final String pageCount;
  final int listLength;
  final Function() onTap;

  const BookItemModel({
    super.key,
    required this.book,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.listLength,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          width: listLength > 1 ? MediaQuery.of(context).size.width * .85 : MediaQuery.of(context).size.width * .90,
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ).bodySmall().onBackground(context),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Publicado em: ").bodySmall().onBackground(context).bold(),
                          Text(
                            publishedDate,
                          ).bodySmall().onBackground(context),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            maxLines: 2,
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
                                      pageCount,
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
                                      Text(book.rating!.isEmpty || book.rating == "null" ? "S/A" : book.rating!).bodySmall().onPrimary(context),
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
