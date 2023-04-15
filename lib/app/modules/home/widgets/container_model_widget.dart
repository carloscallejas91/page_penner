import "package:flutter/material.dart";

class ContainerModelWidget extends StatelessWidget {
  final Color containerColor;
  final Color textColor;
  final String text;

  const ContainerModelWidget({
    Key? key,
    required this.containerColor,
    required this.textColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(8),
        color: containerColor,
        child: Text(
          text,
          style:
              Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor),
        ),
      ),
    );
  }
}
