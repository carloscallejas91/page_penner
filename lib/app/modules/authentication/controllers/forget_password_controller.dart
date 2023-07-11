import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:page_penner/app/widgets/dialog/cc_dialog.dart";
import "package:page_penner/app/widgets/snack_bar/cc_snack_bar.dart";
import "package:page_penner/core/utils/validate_entry_utils.dart";
import "package:page_penner/data/services/auth/auth_service.dart";

class ForgetPasswordController extends GetxController {
  // services
  final AuthService _authService = AuthService();

  // utils
  ValidateEntryUtils validateEntryUtils = ValidateEntryUtils();

  // keys
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController emailController = TextEditingController();

  void validateForm() {
    if (formKey.currentState!.validate()) {
      _resetPassword();
    }
  }

  Future<void> _resetPassword() async {
    CCDialog.loadingWithText(
        message: "Enviando e-mail para redefinir sua senha...");

    _authService.resetPassword(email: emailController.text).then((value) {
      if (value == true) CCDialog.closeDialog();
      CCSnackBar.success(
          message:
              "Você receberá em breve um e-mail com instruções de como redefinir sua senha.");
    });
  }

  void goToLogin() {
    Get.offAllNamed("/login");
  }
}
