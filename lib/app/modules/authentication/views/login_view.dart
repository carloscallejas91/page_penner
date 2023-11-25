import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:page_penner/app/modules/authentication/controllers/login_controller.dart";
import "package:page_penner/app/widgets/button/cc_elevated_button.dart";
import "package:page_penner/app/widgets/template/cc_page_without_app_bar.dart";
import "package:page_penner/core/extensions/text_extension.dart";
import "package:page_penner/core/values/strings.dart";

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CCPageWithoutAppBar(
      backgroundImage: backgroundImage,
      padding: EdgeInsets.zero,
      widgets: [
        Expanded(
          flex: 1,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 64, top: 32, right: 64, bottom: 16),
              child: const Text(
                "Palavras escritas revelam mundos inexplorados.",
              ).displaySmall().onPrimary(context),
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: Card(
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 32, top: 64, right: 32, bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Realizar\nLogin",
                      ).headlineMedium(),
                      const SizedBox(height: 16),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => controller
                                  .validateEntryUtils
                                  .validateEmail(value!),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                labelText: "E-mail",
                                hintText: "exemplo@email.com",
                                prefixIcon: const Icon(
                                  FontAwesomeIcons.solidEnvelope,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Obx(
                              () => TextFormField(
                                controller: controller.passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: controller.obscureText.value,
                                validator: (value) => controller
                                    .validateEntryUtils
                                    .validatePassword(value!),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  labelText: "Senha",
                                  hintText: "Mi@123456",
                                  prefixIcon: const Icon(
                                    FontAwesomeIcons.key,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: controller.togglePasswordSuffixIcon(
                                        isObscureText:
                                            controller.obscureText.value),
                                    onPressed: () {
                                      controller.togglePasswordVisibility();
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: controller.goToForgotPassword,
                                child: const Text("Esqueci minha senha"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: CCElevatedButton(
                      textButton: "Entrar",
                      buttonColor: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      onPressed: controller.validateForm,
                    ),
                  ),
                  TextButton(
                    onPressed: controller.goToCreateAccount,
                    child: const Text("Não tenho uma conta!"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
