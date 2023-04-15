import "package:flutter/material.dart";
import "package:page_penner/app/widgets/card/cc_card.dart";
import "package:page_penner/core/values/colors.dart";
import "package:page_penner/core/values/keys.dart";

class CCSingleListItemModel extends StatelessWidget {
  final BuildContext context;
  final String title;
  final Color titleColor;
  final String? subtitle;
  final Color subtitleColor;
  final IconData? leadingIcon;
  final Color leadingIconColor;
  final IconData? trailingIcon;
  final Color trailingIconColor;
  final Color backgroundColor;
  final Function() onTap;

  const CCSingleListItemModel.primaryContainer({
    Key? key,
    required this.context,
    required this.title,
    this.titleColor = onSurface,
    this.subtitle,
    this.subtitleColor = onSurface,
    this.leadingIcon,
    this.leadingIconColor = onSurface,
    this.trailingIcon = chevronRightIcon,
    this.trailingIconColor = onSurface,
    this.backgroundColor = primaryContainer,
    required this.onTap,
  }) : super(key: key);

  const CCSingleListItemModel.secondaryContainer({
    Key? key,
    required this.context,
    required this.title,
    this.titleColor = onSurface,
    this.subtitle,
    this.subtitleColor = onSurface,
    this.leadingIcon,
    this.leadingIconColor = onSurface,
    this.trailingIcon = chevronRightIcon,
    this.trailingIconColor = onSurface,
    this.backgroundColor = secondaryContainer,
    required this.onTap,
  }) : super(key: key);

  const CCSingleListItemModel.success({
    Key? key,
    required this.context,
    required this.title,
    this.titleColor = onSuccessContainer,
    this.subtitle,
    this.subtitleColor = onSuccessContainer,
    this.leadingIcon,
    this.leadingIconColor = onSuccessContainer,
    this.trailingIcon = chevronRightIcon,
    this.trailingIconColor = onSuccessContainer,
    this.backgroundColor = successContainer,
    required this.onTap,
  }) : super(key: key);

  const CCSingleListItemModel.error({
    Key? key,
    required this.context,
    required this.title,
    this.titleColor = onErrorContainer,
    this.subtitle,
    this.subtitleColor = onErrorContainer,
    this.leadingIcon,
    this.leadingIconColor = onErrorContainer,
    this.trailingIcon = chevronRightIcon,
    this.trailingIconColor = onErrorContainer,
    this.backgroundColor = errorContainer,
    required this.onTap,
  }) : super(key: key);

  const CCSingleListItemModel.neutral({
    Key? key,
    required this.context,
    required this.title,
    this.titleColor = onSurface,
    this.subtitle,
    this.subtitleColor = onSurface,
    this.leadingIcon,
    this.leadingIconColor = onSurface,
    this.trailingIcon = chevronRightIcon,
    this.trailingIconColor = onSurface,
    this.backgroundColor = neutral,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CCCard(
        backgroundColor: backgroundColor,
        widgets: [
          ListTile(
            leading: leadingIcon != null ? Icon(leadingIcon) : null,
            title: Text(
              title,
              style: TextStyle(
                color: titleColor,
              ),
            ),
            subtitle: subtitle != null
                ? Text(
                    subtitle!,
                    style: TextStyle(
                      color: subtitleColor,
                    ),
                  )
                : null,
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  trailingIcon,
                  size: 16,
                  color: trailingIconColor,
                ),
              ],
            ),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
