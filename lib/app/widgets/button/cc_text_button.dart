import "package:flutter/material.dart";
import "package:page_penner/core/values/colors.dart";

class CCTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Function() onPressed;

  const CCTextButton({
    Key? key,
    required this.text,
    this.textColor = primary,
    required this.onPressed,
  }) : super(key: key);

  const CCTextButton.primary({
    Key? key,
    required this.text,
    this.textColor = primary,
    required this.onPressed,
  }) : super(key: key);

  const CCTextButton.secondary({
    Key? key,
    required this.text,
    this.textColor = secondary,
    required this.onPressed,
  }) : super(key: key);

  const CCTextButton.tertiary({
    Key? key,
    required this.text,
    this.textColor = tertiary,
    required this.onPressed,
  }) : super(key: key);

  const CCTextButton.success({
    Key? key,
    required this.text,
    this.textColor = success,
    required this.onPressed,
  }) : super(key: key);

  const CCTextButton.warning({
    Key? key,
    required this.text,
    this.textColor = warning,
    required this.onPressed,
  }) : super(key: key);

  const CCTextButton.error({
    Key? key,
    required this.text,
    this.textColor = error,
    required this.onPressed,
  }) : super(key: key);

  const CCTextButton.neutral({
    Key? key,
    required this.text,
    this.textColor = neutral,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}
