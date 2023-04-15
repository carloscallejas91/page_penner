import "package:flutter/material.dart";
import 'package:page_penner/core/values/colors.dart';

class CCButton extends StatelessWidget {
  final String textButton;
  final Color buttonColor;
  final Color textColor;
  final IconData? icon;
  final bool iconLeft;
  final Function()? onPressed;

  const CCButton.surface({
    Key? key,
    required this.textButton,
    this.buttonColor = surface,
    this.textColor = onSurface,
    this.icon,
    this.iconLeft = false,
    this.onPressed,
  }) : super(key: key);

  const CCButton.surfaceVariant({
    Key? key,
    required this.textButton,
    this.buttonColor = surfaceVariant,
    this.textColor = onSurfaceVariant,
    this.icon,
    this.iconLeft = false,
    this.onPressed,
  }) : super(key: key);

  const CCButton.primary({
    Key? key,
    required this.textButton,
    this.buttonColor = primary,
    this.textColor = onPrimary,
    this.icon,
    this.iconLeft = false,
    this.onPressed,
  }) : super(key: key);

  const CCButton.primaryContainer({
    Key? key,
    required this.textButton,
    this.buttonColor = primaryContainer,
    this.textColor = onPrimaryContainer,
    this.icon,
    this.iconLeft = false,
    this.onPressed,
  }) : super(key: key);

  const CCButton.secondary({
    Key? key,
    required this.textButton,
    this.buttonColor = secondary,
    this.textColor = onSecondary,
    this.icon,
    this.iconLeft = false,
    this.onPressed,
  }) : super(key: key);

  const CCButton.secondaryContainer({
    Key? key,
    required this.textButton,
    this.buttonColor = secondaryContainer,
    this.textColor = onSecondaryContainer,
    this.icon,
    this.iconLeft = false,
    this.onPressed,
  }) : super(key: key);

  const CCButton.tertiary({
    Key? key,
    required this.textButton,
    this.buttonColor = tertiary,
    this.textColor = onTertiary,
    this.icon,
    this.iconLeft = false,
    this.onPressed,
  }) : super(key: key);

  const CCButton.tertiaryContainer({
    Key? key,
    required this.textButton,
    this.buttonColor = tertiaryContainer,
    this.textColor = onTertiaryContainer,
    this.icon,
    this.iconLeft = false,
    this.onPressed,
  }) : super(key: key);

  const CCButton.success({
    Key? key,
    required this.textButton,
    this.buttonColor = success,
    this.textColor = onSuccess,
    this.icon,
    this.iconLeft = false,
    this.onPressed,
  }) : super(key: key);

  const CCButton.successContainer({
    Key? key,
    required this.textButton,
    this.buttonColor = successContainer,
    this.textColor = onSuccessContainer,
    this.icon,
    this.iconLeft = false,
    this.onPressed,
  }) : super(key: key);

  const CCButton.warning({
    Key? key,
    required this.textButton,
    this.buttonColor = warning,
    this.textColor = onWarning,
    this.icon,
    this.iconLeft = false,
    this.onPressed,
  }) : super(key: key);

  const CCButton.warningContainer({
    Key? key,
    required this.textButton,
    this.buttonColor = warningContainer,
    this.textColor = onWarningContainer,
    this.icon,
    this.iconLeft = false,
    required this.onPressed,
  }) : super(key: key);

  const CCButton.error({
    Key? key,
    required this.textButton,
    this.buttonColor = error,
    this.textColor = onError,
    this.icon,
    this.iconLeft = false,
    required this.onPressed,
  }) : super(key: key);

  const CCButton.errorContainer({
    Key? key,
    required this.textButton,
    this.buttonColor = errorContainer,
    this.textColor = onErrorContainer,
    this.icon,
    this.iconLeft = false,
    required this.onPressed,
  }) : super(key: key);

  const CCButton.neutral({
    Key? key,
    required this.textButton,
    this.buttonColor = neutral,
    this.textColor = onNeutral,
    this.icon,
    this.iconLeft = false,
    required this.onPressed,
  }) : super(key: key);

  const CCButton.neutralContainer({
    Key? key,
    required this.textButton,
    this.buttonColor = neutralContainer,
    this.textColor = onNeutralContainer,
    this.icon,
    this.iconLeft = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: textColor,
          disabledBackgroundColor: disable,
          disabledForegroundColor: onDisable,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        child: iconLeft
            ? Row(
                children: [
                  Visibility(
                    visible: icon != null,
                    child: Icon(icon),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        textButton.toUpperCase(),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        textButton.toUpperCase(),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: icon != null,
                    child: Icon(icon),
                  ),
                ],
              ),
      ),
    );
  }
}
