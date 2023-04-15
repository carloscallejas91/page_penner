import "package:flutter/material.dart";
import "package:page_penner/core/values/colors.dart";
import "package:page_penner/core/values/keys.dart";

class CCCard extends StatelessWidget {
  final List<Widget> widgets;
  final EdgeInsets padding;
  final double elevation;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final Color backgroundColor;

  const CCCard({
    Key? key,
    required this.widgets,
    this.padding = defaultPaddingCard,
    this.elevation = 2.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    required this.backgroundColor,
  }) : super(key: key);

  const CCCard.surface({
    Key? key,
    required this.widgets,
    this.padding = defaultPaddingCard,
    this.elevation = 2.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundColor = surface,
  }) : super(key: key);

  const CCCard.surfaceVariant({
    Key? key,
    required this.widgets,
    this.padding = defaultPaddingCard,
    this.elevation = 2.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundColor = surfaceVariant,
  }) : super(key: key);

  const CCCard.primaryContainer({
    Key? key,
    required this.widgets,
    this.padding = defaultPaddingCard,
    this.elevation = 2.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundColor = primaryContainer,
  }) : super(key: key);

  const CCCard.secondaryContainer({
    Key? key,
    required this.widgets,
    this.padding = defaultPaddingCard,
    this.elevation = 2.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundColor = secondaryContainer,
  }) : super(key: key);

  const CCCard.tertiaryContainer({
    Key? key,
    required this.widgets,
    this.padding = defaultPaddingCard,
    this.elevation = 2.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundColor = tertiaryContainer,
  }) : super(key: key);

  const CCCard.success({
    Key? key,
    required this.widgets,
    this.padding = defaultPaddingCard,
    this.elevation = 2.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundColor = success,
  }) : super(key: key);

  const CCCard.successContainer({
    Key? key,
    required this.widgets,
    this.padding = defaultPaddingCard,
    this.elevation = 2.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundColor = successContainer,
  }) : super(key: key);

  const CCCard.warning({
    Key? key,
    required this.widgets,
    this.padding = defaultPaddingCard,
    this.elevation = 2.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundColor = warning,
  }) : super(key: key);

  const CCCard.warningContainer({
    Key? key,
    required this.widgets,
    this.padding = defaultPaddingCard,
    this.elevation = 2.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundColor = warningContainer,
  }) : super(key: key);

  const CCCard.error({
    Key? key,
    required this.widgets,
    this.padding = defaultPaddingCard,
    this.elevation = 2.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundColor = error,
  }) : super(key: key);

  const CCCard.errorContainer({
    Key? key,
    required this.widgets,
    this.padding = defaultPaddingCard,
    this.elevation = 2.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundColor = errorContainer,
  }) : super(key: key);

  const CCCard.neutral({
    Key? key,
    required this.widgets,
    this.padding = defaultPaddingCard,
    this.elevation = 2.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.backgroundColor = neutral,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: backgroundColor,
        elevation: elevation,
        child: Padding(
          padding: padding,
          child: widgets.length > 1
              ? Column(
                  crossAxisAlignment: crossAxisAlignment,
                  mainAxisAlignment: mainAxisAlignment,
                  mainAxisSize: mainAxisSize,
                  children: widgets,
                )
              : widgets[0],
        ),
      ),
    );
  }
}
