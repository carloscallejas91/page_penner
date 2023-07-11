import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:page_penner/app/modules/authentication/controllers/splash_screen_controller.dart";
import "package:page_penner/app/widgets/button/cc_elevated_button.dart";
import "package:page_penner/app/widgets/template/cc_page_without_app_bar.dart";
import "package:page_penner/core/extensions/text_extension.dart";
import "package:page_penner/core/values/strings.dart";

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CCPageWithoutAppBar(
      backgroundImage: backgroundImage,
      padding: const EdgeInsets.only(left: 64, top: 128, right: 64, bottom: 64),
      widgets: [
        Expanded(
          flex: 1,
          child: const Text(
            "A vida é um livro que escrevemos todos os dias.",
          ).displaySmall().onPrimary(context),
        ),
        CCElevatedButton(
          textButton: "Cadastrar-se",
          buttonColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: controller.goToNewAccount,
        ),
        const SizedBox(height: 16),
        CCElevatedButton(
          textButton: "Entrar",
          buttonColor: Theme.of(context).colorScheme.primaryContainer,
          textColor: Theme.of(context).colorScheme.onPrimaryContainer,
          onPressed: controller.goToLogin,
        ),
      ],
    );
  }
}
