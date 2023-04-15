import "package:flutter/material.dart";
import "package:page_penner/core/values/colors.dart";

class CCFloatingActionButtonExtend extends StatelessWidget {
  final String heroTag;
  final String label;
  final Color labelColor;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Function onPressed;

  const CCFloatingActionButtonExtend.primary({
    Key? key,
    required this.heroTag,
    required this.label,
    this.labelColor = onPrimary,
    required this.icon,
    this.iconColor = onPrimary,
    this.backgroundColor = primary,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButtonExtend.primaryContainer({
    Key? key,
    required this.heroTag,
    required this.label,
    this.labelColor = onPrimaryContainer,
    required this.icon,
    this.iconColor = onPrimaryContainer,
    this.backgroundColor = primaryContainer,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButtonExtend.secondary({
    Key? key,
    required this.heroTag,
    required this.label,
    this.labelColor = onSecondary,
    required this.icon,
    this.iconColor = onSecondary,
    this.backgroundColor = secondary,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButtonExtend.secondaryContainer({
    Key? key,
    required this.heroTag,
    required this.label,
    this.labelColor = onSecondaryContainer,
    required this.icon,
    this.iconColor = onSecondaryContainer,
    this.backgroundColor = secondaryContainer,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButtonExtend.tertiary({
    Key? key,
    required this.heroTag,
    required this.label,
    this.labelColor = onTertiary,
    required this.icon,
    this.iconColor = onTertiary,
    this.backgroundColor = tertiary,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButtonExtend.tertiaryContainer({
    Key? key,
    required this.heroTag,
    required this.label,
    this.labelColor = onTertiaryContainer,
    required this.icon,
    this.iconColor = onTertiaryContainer,
    this.backgroundColor = tertiaryContainer,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButtonExtend.success({
    Key? key,
    required this.heroTag,
    required this.label,
    this.labelColor = onSuccess,
    required this.icon,
    this.iconColor = onSuccess,
    this.backgroundColor = success,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButtonExtend.successContainer({
    Key? key,
    required this.heroTag,
    required this.label,
    this.labelColor = onSuccessContainer,
    required this.icon,
    this.iconColor = onSuccessContainer,
    this.backgroundColor = successContainer,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButtonExtend.warning({
    Key? key,
    required this.heroTag,
    required this.label,
    this.labelColor = onWarning,
    required this.icon,
    this.iconColor = onWarning,
    this.backgroundColor = warning,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButtonExtend.warningContainer({
    Key? key,
    required this.heroTag,
    required this.label,
    this.labelColor = onWarningContainer,
    required this.icon,
    this.iconColor = onWarningContainer,
    this.backgroundColor = warningContainer,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButtonExtend.error({
    Key? key,
    required this.heroTag,
    required this.label,
    this.labelColor = onError,
    required this.icon,
    this.iconColor = onError,
    this.backgroundColor = error,
    required this.onPressed,
  }) : super(key: key);

  const CCFloatingActionButtonExtend.errorContainer({
    Key? key,
    required this.heroTag,
    required this.label,
    this.labelColor = onErrorContainer,
    required this.icon,
    this.iconColor = onErrorContainer,
    this.backgroundColor = errorContainer,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: heroTag,
      onPressed: () {
        onPressed();
      },
      label: Text(
        label,
        style: TextStyle(color: labelColor),
      ),
      icon: Icon(
        icon,
        color: iconColor,
      ),
      backgroundColor: backgroundColor,
    );
  }
}
