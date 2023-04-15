import "package:flutter/material.dart";
import "package:page_penner/core/values/colors.dart";

class ColorUtils {
  Color isRedValue(double value) {
    debugPrint("valor: $value");
    if (value == 0) {
      debugPrint("onSurface: $value");
      return onSurface;
    } else if (value > 0) {
      debugPrint("success: $value");
      return success;
    } else if (value < 0) {
      debugPrint("error: $value");
      return error;
    }

    return onSurface;
  }
}
