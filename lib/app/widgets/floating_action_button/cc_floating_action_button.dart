import "package:flutter/material.dart";
import "package:page_penner/core/values/colors.dart";

class CCFloatingActionButton extends StatelessWidget {
  final String heroTag;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Function onPressed;

  const CCFloatingActionButton.primary({
    Key? key,
    required this.heroTag,
    required this.icon,
    this.iconColor = onPrimary,
    this.backgroundColor = primary,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButton.primaryContainer({
    Key? key,
    required this.heroTag,
    required this.icon,
    this.iconColor = onPrimaryContainer,
    this.backgroundColor = primaryContainer,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButton.secondary({
    Key? key,
    required this.heroTag,
    required this.icon,
    this.iconColor = onSecondary,
    this.backgroundColor = secondary,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButton.secondaryContainer({
    Key? key,
    required this.heroTag,
    required this.icon,
    this.iconColor = onSecondaryContainer,
    this.backgroundColor = secondaryContainer,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButton.tertiary({
    Key? key,
    required this.heroTag,
    required this.icon,
    this.iconColor = onTertiary,
    this.backgroundColor = tertiary,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButton.tertiaryContainer({
    Key? key,
    required this.heroTag,
    required this.icon,
    this.iconColor = onTertiaryContainer,
    this.backgroundColor = tertiaryContainer,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButton.success({
    Key? key,
    required this.heroTag,
    required this.icon,
    this.iconColor = onSuccess,
    this.backgroundColor = success,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButton.successContainer({
    Key? key,
    required this.heroTag,
    required this.icon,
    this.iconColor = onSuccessContainer,
    this.backgroundColor = successContainer,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButton.warning({
    Key? key,
    required this.heroTag,
    required this.icon,
    this.iconColor = onWarning,
    this.backgroundColor = warning,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButton.warningContainer({
    Key? key,
    required this.heroTag,
    required this.icon,
    this.iconColor = onWarningContainer,
    this.backgroundColor = warningContainer,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButton.error({
    Key? key,
    required this.heroTag,
    required this.icon,
    this.iconColor = onErrorContainer,
    this.backgroundColor = error,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButton.errorContainer({
    Key? key,
    required this.heroTag,
    required this.icon,
    this.iconColor = onErrorContainer,
    this.backgroundColor = errorContainer,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: () {
        onPressed();
      },
      backgroundColor: backgroundColor,
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
