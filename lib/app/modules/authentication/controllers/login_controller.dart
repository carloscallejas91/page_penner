import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:page_penner/app/widgets/dialog/cc_dialog.dart";
import "package:page_penner/app/widgets/snack_bar/cc_snack_bar.dart";
import "package:page_penner/core/utils/validate_entry_utils.dart";
import "package:page_penner/data/services/auth/auth_service.dart";

class LoginController extends GetxController {
  // services
  final AuthService _authService = AuthService();

  // utils
  ValidateEntryUtils validateEntryUtils = ValidateEntryUtils();

  // keys
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // conditionals
  RxBool obscureText = true.obs;

  // User
  UserCredential? _userCredential;

  void togglePasswordVisibility() {
    if (obscureText.isTrue) {
      obscureText.value = false;
    } else if (obscureText.isFalse) {
      obscureText.value = true;
    }
  }

  Icon togglePasswordSuffixIcon({required bool isObscureText}) {
    if (isObscureText == true) {
      return const Icon(FontAwesomeIcons.solidEyeSlash);
    } else {
      return const Icon(FontAwesomeIcons.solidEye);
    }
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      _login();
    }
  }

  Future<void> _login() async {
    CCDialog.loadingWithText(message: "Realizando login...");

    _authService
        .login(email: emailController.text, password: passwordController.text)
        .then((value) {
      _userCredential = value.$1;
      if (_userCredential != null) {
        CCDialog.closeDialog();
        CCSnackBar.success(message: value.$2);
        goToHome();
      } else {
        CCDialog.closeDialog();
        CCSnackBar.error(message: value.$2);
      }
    });
  }

  void goToCreateAccount() {
    Get.offAllNamed("/new_account");
  }

  void goToForgotPassword() {
    Get.offAllNamed("/forget_password");
  }

  void goToHome() {
    Get.offAllNamed("/home");
  }
}
