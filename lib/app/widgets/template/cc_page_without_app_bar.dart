import "package:flutter/material.dart";

class CCPageWithoutAppBar extends StatelessWidget {
  final EdgeInsets? padding;
  final CrossAxisAlignment columnHorizontalAlignment;
  final MainAxisAlignment columnVerticalAlignment;
  final MainAxisSize mainAxisSize;
  final String? backgroundImage;
  final Color? backgroundColor;
  final bool hasScroll;
  final List<Widget> widgets;

  const CCPageWithoutAppBar({
    Key? key,
    this.padding,
    this.columnHorizontalAlignment = CrossAxisAlignment.start,
    this.columnVerticalAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundImage,
    this.backgroundColor,
    this.hasScroll = true,
    required this.widgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.background,
          image: backgroundImage != null
              ? DecorationImage(
                  image: AssetImage(
                    backgroundImage!,
                  ),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: hasScroll == true
            ? LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: columnHorizontalAlignment,
                          mainAxisAlignment: columnVerticalAlignment,
                          mainAxisSize: mainAxisSize,
                          children: widgets,
                        ),
                      ),
                    ),
                  );
                },
              )
            : Column(
                crossAxisAlignment: columnHorizontalAlignment,
                mainAxisAlignment: columnVerticalAlignment,
                mainAxisSize: mainAxisSize,
                children: widgets,
              ),
      ),
    );
  }
}
