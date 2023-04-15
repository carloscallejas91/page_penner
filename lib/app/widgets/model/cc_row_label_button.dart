import "package:flutter/material.dart";
import "package:page_penner/app/widgets/button/cc_icon_button.dart";
import "package:page_penner/core/values/colors.dart";
import "package:page_penner/core/values/keys.dart";

class CCRowLabelButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final Function onPressed;

  const CCRowLabelButton({
    Key? key,
    required this.label,
    this.icon = arrowRightIcon,
    this.iconColor = primary,
    this.iconSize = 16,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        CCIconButton(
          icon: icon,
          iconColor: iconColor,
          iconSize: iconSize,
          onPressed: () => onPressed,
        ),
      ],
    );
  }
}
