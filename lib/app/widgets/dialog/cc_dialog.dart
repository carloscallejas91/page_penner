import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:page_penner/app/widgets/button/cc_text_button.dart";

mixin CCDialog {
  static void loadingWithText({
    required String message,
    Color? progressColor,
  }) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                  color: progressColor ??
                      Theme.of(Get.context!).colorScheme.primary),
              const SizedBox(width: 16),
              Flexible(
                child: Text(message),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void dialogPositiveButton({
    required String title,
    required Color titleColor,
    IconData? icon,
    required Color iconColor,
    double iconSize = 22,
    required String contentText,
    String namePositiveButton = "Ok",
    required Color colorPositiveButton,
    required Function() onPressedPositiveButton,
  }) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: titleSession(
            title: title,
            icon: icon,
            iconColor: iconColor,
            iconSize: iconSize,
          ),
          content: Text(
            contentText,
            style: TextStyle(
              color: titleColor,
            ),
          ),
          actions: [
            CCTextButton(
              text: namePositiveButton.toUpperCase(),
              textColor: colorPositiveButton,
              onPressed: onPressedPositiveButton,
            ),
          ],
        ),
      ),
    );
  }

  static void dialogNeutralAndPositiveButton({
    required String title,
    required Color titleColor,
    IconData? icon,
    required Color iconColor,
    double iconSize = 22,
    required String contentText,
    String nameNeutralButton = "Cancelar",
    required Color colorNeutralButton,
    required Function() onPressedNeutralButton,
    String namePositiveButton = "Ok",
    required Color colorPositiveButton,
    required Function() onPressedPositiveButton,
  }) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: titleSession(
            title: title,
            icon: icon,
            iconColor: iconColor,
            iconSize: iconSize,
          ),
          content: Text(
            contentText,
            style: TextStyle(
              color: titleColor,
            ),
          ),
          actions: [
            CCTextButton(
              text: nameNeutralButton.toUpperCase(),
              textColor: colorNeutralButton,
              onPressed: onPressedNeutralButton,
            ),
            CCTextButton(
              text: namePositiveButton.toUpperCase(),
              textColor: colorPositiveButton,
              onPressed: onPressedPositiveButton,
            ),
          ],
        ),
      ),
    );
  }

  static void dialogNeutralNegativeAndPositiveButton({
    required BuildContext context,
    required String title,
    Color? titleColor,
    IconData? icon,
    Color? iconColor,
    double iconSize = 22,
    required String contentText,
    String nameNeutralButton = "Cancelar",
    Color? colorNeutralButton,
    required Function() onPressedNeutralButton,
    String nameNegativeButton = "Excluir",
    Color? colorNegativeButton,
    required Function() onPressedNegativeButton,
    String namePositiveButton = "Confirmar",
    Color? colorPositiveButton,
    required Function() onPressedPositiveButton,
  }) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: titleSession(
            title: title,
            icon: icon,
            iconColor: iconColor ?? Theme.of(context).colorScheme.primary,
            iconSize: iconSize,
          ),
          content: Text(
            contentText,
            style: TextStyle(
              color: titleColor ?? Theme.of(context).colorScheme.onSurface,
            ),
          ),
          actions: [
            CCTextButton(
              text: nameNeutralButton.toUpperCase(),
              textColor:
                  colorNeutralButton ?? Theme.of(context).colorScheme.outline,
              onPressed: onPressedNeutralButton,
            ),
            CCTextButton(
              text: nameNegativeButton.toUpperCase(),
              textColor:
                  colorNegativeButton ?? Theme.of(context).colorScheme.error,
              onPressed: onPressedNegativeButton,
            ),
            CCTextButton(
              text: namePositiveButton.toUpperCase(),
              textColor:
                  colorPositiveButton ?? Theme.of(context).colorScheme.primary,
              onPressed: onPressedPositiveButton,
            ),
          ],
        ),
      ),
    );
  }

  static void closeDialog() {
    Get.back();
  }

  static Widget titleSession({
    required String title,
    IconData? icon,
    Color? iconColor,
    double? iconSize,
  }) {
    return Row(
      children: [
        Visibility(
          visible: icon != null,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
        ),
        Flexible(
          child: Text(title),
        ),
      ],
    );
  }
}
