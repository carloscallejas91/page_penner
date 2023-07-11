import "package:flutter/material.dart";

extension CustomColorScheme on ColorScheme {
  Color get success => brightness == Brightness.light ? const Color(0xFF4CAF50) : const Color(0xFF111111);
  Color get onSuccess => brightness == Brightness.light ? const Color(0xFFFFFFFF) : const Color(0xFF999999);
  Color get successContainer => brightness == Brightness.light ? const Color(0xFFC8E6C9) : const Color(0xFF111111);
  Color get onSuccessContainer => brightness == Brightness.light ? const Color(0xFF1B5E20) : const Color(0xFF999999);

  Color get warning => brightness == Brightness.light ? const Color(0xFFFF9800) : const Color(0xFF111111);
  Color get onWarning => brightness == Brightness.light ? const Color(0xFFFFFFFF) : const Color(0xFF999999);
  Color get warningContainer => brightness == Brightness.light ? const Color(0xFFFFE0B2) : const Color(0xFF111111);
  Color get onWarningContainer => brightness == Brightness.light ? const Color(0xFFE65100) : const Color(0xFF999999);
}