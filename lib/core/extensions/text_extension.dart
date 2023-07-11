import "package:flutter/material.dart";
import "package:page_penner/core/theme/text_theme.dart";

extension TextExtension on Text {
  // Color
  Text white() => copyWith(style: const TextStyle(color: Colors.white));

  Text black() => copyWith(style: const TextStyle(color: Colors.black));

  Text red() => copyWith(style: const TextStyle(color: Colors.red));

  Text pink() => copyWith(style: const TextStyle(color: Colors.pink));

  Text purple() => copyWith(style: const TextStyle(color: Colors.purple));

  Text deepPurple() => copyWith(style: const TextStyle(color: Colors.deepPurple));

  Text indigo() => copyWith(style: const TextStyle(color: Colors.indigo));

  Text blue() => copyWith(style: const TextStyle(color: Colors.blue));

  Text lightBlue() => copyWith(style: const TextStyle(color: Colors.lightBlue));

  Text cyan() => copyWith(style: const TextStyle(color: Colors.cyan));

  Text teal() => copyWith(style: const TextStyle(color: Colors.teal));

  Text green() => copyWith(style: const TextStyle(color: Colors.green));

  Text lightGreen() => copyWith(style: const TextStyle(color: Colors.lightGreen));

  Text lime() => copyWith(style: const TextStyle(color: Colors.lime));

  Text yellow() => copyWith(style: const TextStyle(color: Colors.yellow));

  Text amber() => copyWith(style: const TextStyle(color: Colors.amber));

  Text orange() => copyWith(style: const TextStyle(color: Colors.orange));

  Text deepOrange() => copyWith(style: const TextStyle(color: Colors.deepOrange));

  Text brown() => copyWith(style: const TextStyle(color: Colors.brown));

  Text grey() => copyWith(style: const TextStyle(color: Colors.grey));

  Text blueGrey() => copyWith(style: const TextStyle(color: Colors.blueGrey));

  Text redAccent() => copyWith(style: const TextStyle(color: Colors.redAccent));

  Text pinkAccent() => copyWith(style: const TextStyle(color: Colors.pinkAccent));

  Text purpleAccent() => copyWith(style: const TextStyle(color: Colors.purpleAccent));

  Text deepPurpleAccent() => copyWith(style: const TextStyle(color: Colors.deepPurpleAccent));

  Text indigoAccent() => copyWith(style: const TextStyle(color: Colors.indigoAccent));

  Text blueAccent() => copyWith(style: const TextStyle(color: Colors.blueAccent));

  Text lightBlueAccent() => copyWith(style: const TextStyle(color: Colors.lightBlueAccent));

  Text cyanAccent() => copyWith(style: const TextStyle(color: Colors.cyanAccent));

  Text tealAccent() => copyWith(style: const TextStyle(color: Colors.tealAccent));

  Text greenAccent() => copyWith(style: const TextStyle(color: Colors.greenAccent));

  Text lightGreenAccent() => copyWith(style: const TextStyle(color: Colors.lightGreenAccent));

  Text limeAccent() => copyWith(style: const TextStyle(color: Colors.limeAccent));

  Text yellowAccent() => copyWith(style: const TextStyle(color: Colors.yellowAccent));

  Text amberAccent() => copyWith(style: const TextStyle(color: Colors.amberAccent));

  Text orangeAccent() => copyWith(style: const TextStyle(color: Colors.orangeAccent));

  Text deepOrangeAccent() => copyWith(style: const TextStyle(color: Colors.deepOrangeAccent));

  Text setColor(Color? color) => copyWith(style: TextStyle(color: color));

  Text setBackgroundColor(Color color) => copyWith(style: TextStyle(backgroundColor: color));

  // ColorSheme
  Text primary(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.primary));

  Text onPrimary(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.onPrimary));

  Text primaryContainer(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.primaryContainer));

  Text onPrimaryContainer(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer));

  Text secondary(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.secondary));

  Text onSecondary(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.onSecondary));

  Text secondaryContainer(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.secondaryContainer));

  Text onSecondaryContainer(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer));

  Text tertiary(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.tertiary));

  Text onTertiary(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.onTertiary));

  Text tertiaryContainer(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer));

  Text onTertiaryContainer(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer));

  Text error(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.error));

  Text onError(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.onError));

  Text background(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.background));

  Text onBackground(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.onBackground));

  Text surface(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.surface));

  Text onSurface(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.onSurface));

  Text surfaceVariant(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.surfaceVariant));

  Text onSurfaceVariant(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant));

  Text inverseSurface(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.inverseSurface));

  Text onInverseSurface(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.onInverseSurface));

  Text inversePrimary(BuildContext context) => copyWith(style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary));

  // TextTheme
  Text displayLarge() => copyWith(style: textTheme.displayLarge);

  Text displayMedium() => copyWith(style: textTheme.displayMedium);

  Text displaySmall() => copyWith(style: textTheme.displaySmall);

  Text headlineLarge() => copyWith(style: textTheme.headlineLarge);

  Text headlineMedium() => copyWith(style: textTheme.headlineMedium);

  Text headlineSmall() => copyWith(style: textTheme.headlineSmall);

  Text titleLarge() => copyWith(style: textTheme.titleLarge);

  Text titleMedium() => copyWith(style: textTheme.titleMedium);

  Text titleSmall() => copyWith(style: textTheme.titleSmall);

  Text labelLarge() => copyWith(style: textTheme.labelLarge);

  Text labelMedium() => copyWith(style: textTheme.labelMedium);

  Text labelSmall() => copyWith(style: textTheme.labelSmall);

  Text bodyLarge() => copyWith(style: textTheme.bodyLarge);

  Text bodyMedium() => copyWith(style: textTheme.bodyMedium);

  Text bodySmall() => copyWith(style: textTheme.bodySmall);

  // FontSize
  Text setFontSize(double fontSize) => copyWith(style: TextStyle(fontSize: fontSize));

  // FontWeight
  Text thin() => copyWith(style: const TextStyle(fontWeight: FontWeight.w100));

  Text extraLight() => copyWith(style: const TextStyle(fontWeight: FontWeight.w200));

  Text light() => copyWith(style: const TextStyle(fontWeight: FontWeight.w300));

  Text medium() => copyWith(style: const TextStyle(fontWeight: FontWeight.w500));

  Text semiBold() => copyWith(style: const TextStyle(fontWeight: FontWeight.w600));

  Text bold() => copyWith(style: const TextStyle(fontWeight: FontWeight.bold));

  Text extraBold() => copyWith(style: const TextStyle(fontWeight: FontWeight.w800));

  Text boldBlack() => copyWith(style: const TextStyle(fontWeight: FontWeight.w900));

  Text setFontWeight(FontWeight fontWeight) => copyWith(style: TextStyle(fontWeight: fontWeight));


  // FontStyle
  Text italic() => copyWith(style: const TextStyle(fontStyle: FontStyle.italic));

  Text normal() => copyWith(style: const TextStyle(fontStyle: FontStyle.normal));

  Text setFontStyle(FontStyle fontStyle) => copyWith(style: TextStyle(fontStyle: fontStyle));

  // LetterSpacing
  Text setLetterSpacing(double letterSpacing) => copyWith(style: TextStyle(letterSpacing: letterSpacing));

  // WordSpacing
  Text setWordSpacing(double wordSpacing) => copyWith(style: TextStyle(wordSpacing: wordSpacing));

  // Decoration
  Text underline() => copyWith(style: const TextStyle(decoration: TextDecoration.underline));

  Text lineThrough() => copyWith(style: const TextStyle(decoration: TextDecoration.lineThrough));

  Text overline() => copyWith(style: const TextStyle(decoration: TextDecoration.overline));

  Text setDecoration(TextDecoration decoration) => copyWith(style: TextStyle(decoration: decoration));

  // Decoration color
  Text setDecorationColor(Color decorationColor) => copyWith(style: TextStyle(decorationColor: decorationColor));


  // Align
  Text left() => copyWith(textAlign: TextAlign.left);

  Text right() => copyWith(textAlign: TextAlign.right);

  Text center() => copyWith(textAlign: TextAlign.center);

  Text justify() => copyWith(textAlign: TextAlign.justify);

  Text start() => copyWith(textAlign: TextAlign.start);

  Text end() => copyWith(textAlign: TextAlign.end);

  Text setTextAlign(TextAlign textAlign) => copyWith(textAlign: textAlign);

  // TextDirection
  Text rtl() => copyWith(textDirection: TextDirection.rtl);

  Text ltr() => copyWith(textDirection: TextDirection.ltr);

  Text setTextDirection(TextDirection textDirection) => copyWith(textDirection: textDirection);

  // Overflow
  Text visible() => copyWith(overflow: TextOverflow.visible);

  Text clip() => copyWith(overflow: TextOverflow.clip);

  Text fade() => copyWith(overflow: TextOverflow.fade);

  Text ellipsis() => copyWith(overflow: TextOverflow.ellipsis);

  Text setOverflow(TextOverflow overflow) => copyWith(overflow: overflow);

  // MaxLines
  Text setMaxLines(int maxLines) => copyWith(maxLines: maxLines);

  // Style
  Text setStyle(TextStyle style) => copyWith(style: style);

  // Opacity
  Opacity opacity(double opacity) => Opacity(opacity: opacity, child: copyWith());

  // Padding
  Padding padding(EdgeInsetsGeometry padding) => Padding(padding: padding, child: copyWith());

  /// Creates a copy of this Text but the given fields will be replaced with
  /// the new values.
  Text copyWith(
      {Key? key,
      StrutStyle? strutStyle,
      TextAlign? textAlign,
      TextDirection textDirection = TextDirection.ltr,
      Locale? locale,
      bool? softWrap,
      TextOverflow? overflow,
      double? textScaleFactor,
      int? maxLines,
      String? semanticsLabel,
      TextWidthBasis? textWidthBasis,
      TextStyle? style,}
      ) {
    return Text(
        data ?? "",
        key: key ?? this.key,
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: textAlign ?? this.textAlign,
        textDirection: textDirection,
        locale: locale ?? this.locale,
        softWrap: softWrap ?? this.softWrap,
        overflow: overflow ?? this.overflow,
        textScaleFactor: textScaleFactor ?? this.textScaleFactor,
        maxLines: maxLines ?? this.maxLines,
        semanticsLabel: semanticsLabel ?? this.semanticsLabel,
        textWidthBasis: textWidthBasis ?? this.textWidthBasis,
        style: style != null ? this.style?.merge(style) ?? style : this.style,
    );
  }
}
