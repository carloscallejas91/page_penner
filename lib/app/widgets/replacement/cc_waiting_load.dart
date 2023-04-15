import "package:flutter/material.dart";
import "package:page_penner/core/values/colors.dart";

class CCWaitingLoad extends StatelessWidget {
  const CCWaitingLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        content: Row(
          children: const [
            CircularProgressIndicator(color: primary),
            SizedBox(width: 16),
            Flexible(
              child: Text("Carregando informações..."),
            ),
          ],
        ),
      ),
    );
  }
}
