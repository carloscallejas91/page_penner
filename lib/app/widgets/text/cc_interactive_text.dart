import "package:flutter/material.dart";
import "package:page_penner/app/widgets/button/cc_text_button.dart";

class CCInteractiveText extends StatelessWidget {
  final String text;
  final String interactiveText;
  final Function interactiveOnPressed;

  const CCInteractiveText({
    Key? key,
    required this.text,
    required this.interactiveText,
    required this.interactiveOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: Text(text)),
        CCTextButton.primary(
          text: interactiveText,
          onPressed: () {
            interactiveOnPressed();
          },
        ),
      ],
    );
  }
}
