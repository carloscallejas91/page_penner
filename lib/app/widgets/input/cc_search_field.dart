import "package:flutter/material.dart";
import 'package:page_penner/core/values/colors.dart';
import 'package:page_penner/core/values/keys.dart';

class CCSearchField extends StatelessWidget {
  final String hintText;
  final Color textColor;
  final Color underlineColor;
  final IconData iconData;
  final Color iconColor;
  final FocusNode? focusNode;
  final Function(String) onChanged;

  const CCSearchField({
    Key? key,
    this.hintText = "Pesquisar",
    this.textColor = onPrimary,
    this.underlineColor = onPrimary,
    this.iconData = searchIcon,
    this.iconColor = onPrimary,
    this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      style: TextStyle(color: textColor),
      textAlign: TextAlign.start,
      onChanged: (value) => onChanged(value),
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: underlineColor, width: 1),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: underlineColor, width: 1),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: underlineColor, width: 1),
        ),
        prefixIcon: Icon(
          iconData,
          size: 16,
          color: iconColor,
        ),
        hintText: hintText,
        isDense: true,
      ),
    );
  }
}
