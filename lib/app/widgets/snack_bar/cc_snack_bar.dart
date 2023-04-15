import "package:flutter/material.dart";
import "package:page_penner/core/values/colors.dart";

class CCSnackBar {
  final String message;
  final Color backgroundColor;
  final Color labelColor;

  CCSnackBar.primary({
    required this.message,
    this.backgroundColor = primary,
    this.labelColor = onPrimary,
  });

  CCSnackBar.primaryContainer({
    required this.message,
    this.backgroundColor = primaryContainer,
    this.labelColor = onPrimaryContainer,
  });

  CCSnackBar.secondary({
    required this.message,
    this.backgroundColor = secondary,
    this.labelColor = onSecondary,
  });

  CCSnackBar.secondaryContainer({
    required this.message,
    this.backgroundColor = secondaryContainer,
    this.labelColor = onSecondaryContainer,
  });

  CCSnackBar.tertiary({
    required this.message,
    this.backgroundColor = tertiary,
    this.labelColor = onTertiary,
  });

  CCSnackBar.tertiaryContainer({
    required this.message,
    this.backgroundColor = tertiaryContainer,
    this.labelColor = onTertiaryContainer,
  });

  CCSnackBar.success({
    required this.message,
    this.backgroundColor = success,
    this.labelColor = onSuccess,
  });

  CCSnackBar.warning({
    required this.message,
    this.backgroundColor = warning,
    this.labelColor = onWarning,
  });

  CCSnackBar.error({
    required this.message,
    this.backgroundColor = error,
    this.labelColor = onError,
  });

  SnackBar show() {
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: Text(message),
      action: SnackBarAction(
        label: "Fechar",
        textColor: labelColor,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );

    return snackBar;
  }
}
