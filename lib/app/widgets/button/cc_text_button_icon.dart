import "package:flutter/material.dart";
import "package:page_penner/core/values/colors.dart";

class CCTextButtonIcon extends StatelessWidget {
  final String text;
  final Color textColor;
  final IconData icon;
  final Color iconColor;
  final Alignment alignment;
  final Function onPressed;

  const CCTextButtonIcon.primary({
    Key? key,
    required this.text,
    this.textColor = primary,
    required this.icon,
    this.iconColor = primary,
    this.alignment = Alignment.center,
    required this.onPressed,
  }) : super(key: key);

  const CCTextButtonIcon.secondary({
    Key? key,
    required this.text,
    this.textColor = secondary,
    required this.icon,
    this.iconColor = secondary,
    this.alignment = Alignment.center,
    required this.onPressed,
  }) : super(key: key);

  const CCTextButtonIcon.tertiary({
    Key? key,
    required this.text,
    this.textColor = tertiary,
    required this.icon,
    this.iconColor = tertiary,
    this.alignment = Alignment.center,
    required this.onPressed,
  }) : super(key: key);

  const CCTextButtonIcon.success({
    Key? key,
    required this.text,
    this.textColor = success,
    required this.icon,
    this.iconColor = success,
    this.alignment = Alignment.center,
    required this.onPressed,
  }) : super(key: key);

  const CCTextButtonIcon.warning({
    Key? key,
    required this.text,
    this.textColor = warning,
    required this.icon,
    this.iconColor = warning,
    this.alignment = Alignment.center,
    required this.onPressed,
  }) : super(key: key);

  const CCTextButtonIcon.error({
    Key? key,
    required this.text,
    this.textColor = error,
    required this.icon,
    this.iconColor = error,
    this.alignment = Alignment.center,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton.icon(
        onPressed: () {
          onPressed();
        },
        label: Icon(
          icon,
          color: iconColor,
        ),
        icon: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
