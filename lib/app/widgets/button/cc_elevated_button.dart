import "package:flutter/material.dart";

class CCElevatedButton extends StatelessWidget {
  final String textButton;
  final Color buttonColor;
  final Color textColor;
  final IconData? icon;
  final bool iconLeft;
  final Function()? onPressed;

  const CCElevatedButton({
    Key? key,
    required this.textButton,
    required this.buttonColor,
    required this.textColor,
    this.icon,
    this.iconLeft = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: textColor,
          disabledBackgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          disabledForegroundColor:
              Theme.of(context).colorScheme.onSurfaceVariant,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
        ),
        child: iconLeft
            ? Row(
                children: [
                  Visibility(
                    visible: icon != null,
                    child: Icon(icon),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        textButton.toUpperCase(),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        textButton.toUpperCase(),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: icon != null,
                    child: Icon(icon),
                  ),
                ],
              ),
      ),
    );
  }
}
