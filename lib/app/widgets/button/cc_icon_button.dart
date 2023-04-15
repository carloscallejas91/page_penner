import "package:flutter/material.dart";
import "package:page_penner/core/values/colors.dart";

class CCIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final Function() onPressed;

  const CCIconButton({
    Key? key,
    required this.icon,
    this.iconColor = primary,
    this.iconSize = 16,
    required this.onPressed,
  }) : super(key: key);

  const CCIconButton.primary({
    Key? key,
    required this.icon,
    this.iconColor = primary,
    this.iconSize = 16,
    required this.onPressed,
  }) : super(key: key);

  const CCIconButton.secondary({
    Key? key,
    required this.icon,
    this.iconColor = secondary,
    this.iconSize = 16,
    required this.onPressed,
  }) : super(key: key);

  const CCIconButton.tertiary({
    Key? key,
    required this.icon,
    this.iconColor = tertiary,
    this.iconSize = 16,
    required this.onPressed,
  }) : super(key: key);

  const CCIconButton.success({
    Key? key,
    required this.icon,
    this.iconColor = success,
    this.iconSize = 16,
    required this.onPressed,
  }) : super(key: key);

  const CCIconButton.warning({
    Key? key,
    required this.icon,
    this.iconColor = warning,
    this.iconSize = 16,
    required this.onPressed,
  }) : super(key: key);

  const CCIconButton.error({
    Key? key,
    required this.icon,
    this.iconColor = error,
    this.iconSize = 16,
    required this.onPressed,
  }) : super(key: key);

  const CCIconButton.neutral({
    Key? key,
    required this.icon,
    this.iconColor = neutral,
    this.iconSize = 16,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
