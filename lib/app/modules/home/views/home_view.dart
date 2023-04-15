import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:page_penner/app/modules/home/controllers/home_controller.dart';
import 'package:page_penner/app/modules/home/widgets/container_model_widget.dart';
import 'package:page_penner/core/values/colors.dart';
import 'package:page_penner/core/values/keys.dart';
import 'package:page_penner/core/values/strings.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(titleApplication),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: backgroundVariant,
        padding: defaultPaddingBody,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: const [
                  ContainerModelWidget(
                    containerColor: primary,
                    textColor: onPrimary,
                    text: "primary",
                  ),
                  ContainerModelWidget(
                    containerColor: onPrimary,
                    textColor: primary,
                    text: "on primary",
                  ),
                  ContainerModelWidget(
                    containerColor: primaryContainer,
                    textColor: onPrimaryContainer,
                    text: "primary container",
                  ),
                  ContainerModelWidget(
                    containerColor: onPrimaryContainer,
                    textColor: primaryContainer,
                    text: "on primary container",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  ContainerModelWidget(
                    containerColor: secondary,
                    textColor: onSecondary,
                    text: "secondary",
                  ),
                  ContainerModelWidget(
                    containerColor: onSecondary,
                    textColor: secondary,
                    text: "on secondary",
                  ),
                  ContainerModelWidget(
                    containerColor: secondaryContainer,
                    textColor: onSecondaryContainer,
                    text: "secondary container",
                  ),
                  ContainerModelWidget(
                    containerColor: onSecondaryContainer,
                    textColor: secondaryContainer,
                    text: "on secondary container",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  ContainerModelWidget(
                    containerColor: tertiary,
                    textColor: onTertiary,
                    text: "tertiary",
                  ),
                  ContainerModelWidget(
                    containerColor: onTertiary,
                    textColor: tertiary,
                    text: "on tertiary",
                  ),
                  ContainerModelWidget(
                    containerColor: tertiaryContainer,
                    textColor: onTertiaryContainer,
                    text: "tertiary container",
                  ),
                  ContainerModelWidget(
                    containerColor: onTertiaryContainer,
                    textColor: tertiaryContainer,
                    text: "on tertiary container",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  ContainerModelWidget(
                    containerColor: background,
                    textColor: onBackground,
                    text: "background",
                  ),
                  ContainerModelWidget(
                    containerColor: onBackground,
                    textColor: background,
                    text: "on background",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  ContainerModelWidget(
                    containerColor: surface,
                    textColor: onSurface,
                    text: "surface",
                  ),
                  ContainerModelWidget(
                    containerColor: onSurface,
                    textColor: surface,
                    text: "on surface",
                  ),
                  ContainerModelWidget(
                    containerColor: surfaceVariant,
                    textColor: onSurfaceVariant,
                    text: "surface variant",
                  ),
                  ContainerModelWidget(
                    containerColor: onSurfaceVariant,
                    textColor: surfaceVariant,
                    text: "on surface variant",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  ContainerModelWidget(
                    containerColor: error,
                    textColor: onError,
                    text: "error",
                  ),
                  ContainerModelWidget(
                    containerColor: onError,
                    textColor: error,
                    text: "on error",
                  ),
                  ContainerModelWidget(
                    containerColor: errorContainer,
                    textColor: onErrorContainer,
                    text: "error container",
                  ),
                  ContainerModelWidget(
                    containerColor: onErrorContainer,
                    textColor: errorContainer,
                    text: "on error container",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  ContainerModelWidget(
                    containerColor: success,
                    textColor: onSuccess,
                    text: "success",
                  ),
                  ContainerModelWidget(
                    containerColor: onSuccess,
                    textColor: success,
                    text: "on success",
                  ),
                  ContainerModelWidget(
                    containerColor: successContainer,
                    textColor: onSuccessContainer,
                    text: "success container",
                  ),
                  ContainerModelWidget(
                    containerColor: onSuccessContainer,
                    textColor: successContainer,
                    text: "on success container",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  ContainerModelWidget(
                    containerColor: warning,
                    textColor: onWarning,
                    text: "warning",
                  ),
                  ContainerModelWidget(
                    containerColor: onWarning,
                    textColor: warning,
                    text: "on warning",
                  ),
                  ContainerModelWidget(
                    containerColor: warningContainer,
                    textColor: onWarningContainer,
                    text: "warning container",
                  ),
                  ContainerModelWidget(
                    containerColor: onWarningContainer,
                    textColor: warningContainer,
                    text: "on warning container",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
