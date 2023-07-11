import "package:flutter/material.dart";

class CCTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Function() onPressed;

  const CCTextButton({
    Key? key,
    required this.text,
    required this.textColor,
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