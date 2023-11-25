import "package:flutter/material.dart";

class CCProgressIndicator extends StatelessWidget {
  final String? message;

  const CCProgressIndicator({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(message ?? ""),
        ],
      ),
    );
  }
}
