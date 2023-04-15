import "package:flutter/material.dart";
import "package:page_penner/core/values/colors.dart";

class CCValueLabel extends StatelessWidget {
  final String value;
  final Color valueColor;
  final String label;
  final Color labelColor;

  const CCValueLabel({
    Key? key,
    required this.value,
    this.valueColor = onSurface,
    required this.label,
    this.labelColor = onSurface,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(color: valueColor),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: labelColor),
        ),
      ],
    );
  }
}
