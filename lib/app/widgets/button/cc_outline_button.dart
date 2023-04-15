import "package:flutter/material.dart";
import "package:page_penner/core/values/colors.dart";

class CCOutlineButton extends StatelessWidget {
  final String textButton;
  final Color color;
  final double borderWidth;
  final Function() onPressed;

  const CCOutlineButton({
    Key? key,
    required this.textButton,
    this.color = primary,
    this.borderWidth = 1,
    required this.onPressed,
  }) : super(key: key);

  const CCOutlineButton.primary({
    Key? key,
    required this.textButton,
    this.color = primary,
    this.borderWidth = 1,
    required this.onPressed,
  }) : super(key: key);

  const CCOutlineButton.secondary({
    Key? key,
    required this.textButton,
    this.color = secondary,
    this.borderWidth = 1,
    required this.onPressed,
  }) : super(key: key);

  const CCOutlineButton.tertiary({
    Key? key,
    required this.textButton,
    this.color = tertiary,
    this.borderWidth = 1,
    required this.onPressed,
  }) : super(key: key);

  const CCOutlineButton.success({
    Key? key,
    required this.textButton,
    this.color = success,
    this.borderWidth = 1,
    required this.onPressed,
  }) : super(key: key);

  const CCOutlineButton.warning({
    Key? key,
    required this.textButton,
    this.color = warning,
    this.borderWidth = 1,
    required this.onPressed,
  }) : super(key: key);

  const CCOutlineButton.error({
    Key? key,
    required this.textButton,
    this.color = error,
    this.borderWidth = 1,
    required this.onPressed,
  }) : super(key: key);

  const CCOutlineButton.neutral({
    Key? key,
    required this.textButton,
    this.color = neutral,
    this.borderWidth = 1,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        side: BorderSide(
          width: borderWidth,
          color: color,
        ),
      ),
      child: Text(
        textButton.toUpperCase(),
        style: TextStyle(color: color),
      ),
    );
  }
}
