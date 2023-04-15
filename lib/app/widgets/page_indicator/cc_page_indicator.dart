import "package:flutter/material.dart";
import "package:page_penner/core/values/colors.dart";

class CCPageIndicator extends StatelessWidget {
  final int pageLenght;
  final int currentPage;

  const CCPageIndicator({
    Key? key,
    required this.pageLenght,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageLenght, (index) {
        return Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index ? primary : secondary,
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
          ),
        );
      }),
    );
  }
}
