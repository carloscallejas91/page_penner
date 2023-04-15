import "package:flutter/material.dart";
import "package:page_penner/core/theme/text_theme.dart";
import "package:page_penner/core/values/colors.dart";

class CustomThemeData {
  CustomThemeData._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        background: background,
        onBackground: onBackground,
        surface: surface,
        onSurface: onSurface,
        surfaceVariant: surfaceVariant,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
      ),
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        color: primary,
        foregroundColor: onPrimary,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: neutral),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        selectionHandleColor: tertiary,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData();
  }
}
