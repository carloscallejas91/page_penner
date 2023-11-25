import "package:flutter/material.dart";
import "package:page_penner/core/values/strings.dart";

class BookAvatarWidget extends StatelessWidget {
  final String? bookUrl;
  final String? urlImageNotFound;
  final bool? hasShadow;

  const BookAvatarWidget(
      {Key? key, required this.bookUrl, this.urlImageNotFound, this.hasShadow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.only(bottomLeft: Radius.circular(20.0)),
        boxShadow: hasShadow!
            ? [
                const BoxShadow(
                  color: Color(0x54000000),
                  spreadRadius: 4,
                  blurRadius: 20,
                ),
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: bookUrl != null
            ? Image.network(
                bookUrl!,
                fit: BoxFit.cover,
              )
            : Image.asset(
                urlImageNotFound == null ? notFoundImage : urlImageNotFound!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
