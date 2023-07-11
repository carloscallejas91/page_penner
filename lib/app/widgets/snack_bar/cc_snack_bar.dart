import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:page_penner/core/theme/colors.dart";

mixin CCSnackBar {
  static void info({required String message}) {
    show(
        message: message,
        backgroundColor: Theme.of(Get.context!).colorScheme.primary);
  }

  static void success({required String message, int? duration}) {
    show(
        message: message,
        backgroundColor: Theme.of(Get.context!).colorScheme.success);
  }

  static void error({required String message}) {
    show(
        message: message,
        backgroundColor: Theme.of(Get.context!).colorScheme.error);
  }

  static void show({
    required String message,
    required Color backgroundColor,
    int? duration,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: backgroundColor,
        duration: Duration(
          seconds: duration ?? 3,
        ),
      ),
    );
  }
}
