import "package:flutter/material.dart";

class CCExpansionTile extends StatelessWidget {
  final GlobalKey globalKey;
  final String title;
  final FontWeight titleWeight;
  final String? subtitle;
  final EdgeInsets tilePadding;
  final EdgeInsets childrenPadding;
  final bool initiallyExpanded;
  final List<Widget> widgets;
  final Function onExpansionChanged;

  const CCExpansionTile({
    Key? key,
    required this.globalKey,
    required this.title,
    this.titleWeight = FontWeight.w500,
    this.subtitle,
    this.tilePadding = EdgeInsets.zero,
    this.childrenPadding = EdgeInsets.zero,
    required this.initiallyExpanded,
    required this.widgets,
    required this.onExpansionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        key: globalKey,
        tilePadding: tilePadding,
        childrenPadding: childrenPadding,
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: titleWeight),
        ),
        subtitle: subtitle != null
            ? Row(
                children: [
                  Text(
                    subtitle!,
                  ),
                ],
              )
            : null,
        initiallyExpanded: initiallyExpanded,
        onExpansionChanged: (val) {
          onExpansionChanged(val);
        },
        children: widgets,
      ),
    );
  }
}
