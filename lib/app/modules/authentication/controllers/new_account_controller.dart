import "dart:io";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";
import "package:page_penner/app/widgets/dialog/cc_dialog.dart";
import "package:page_penner/app/widgets/snack_bar/cc_snack_bar.dart";
import "package:page_penner/core/utils/validate_entry_utils.dart";
import "package:page_penner/data/services/auth/auth_service.dart";

class NewAccountController extends GetxController {
  // services
  final AuthService _authService = AuthService();

  // utils
  ValidateEntryUtils validateEntryUtils = ValidateEntryUtils();

  // keys
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // conditionals
  RxBool obscureText = true.obs;

  // Image path
  Rx<File> profileImageFile = File("").obs;

  // User
  UserCredential? _userCredential;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

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

  void chooseImageCapture({required BuildContext context}) {
    CCDialog.dialogNeutralNegativeAndPositiveButton(
      context: context,
      title: "Perfil",
      contentText:
          "Escolha uma das opções para selecionar sua imagem de perfil.",
      nameNeutralButton: "Ligar câmera",
      colorNeutralButton: Theme.of(context).colorScheme.primary,
      onPressedNeutralButton: () {
        CCDialog.closeDialog();
        registerPhoto();
      },
      nameNegativeButton: "Escolher imagem",
      colorNegativeButton: Theme.of(context).colorScheme.primary,
      onPressedNegativeButton: () {
        CCDialog.closeDialog();
        selectImage();
      },
      namePositiveButton: "Cancelar",
      colorPositiveButton: Theme.of(context).colorScheme.outline,
      onPressedPositiveButton: CCDialog.closeDialog,
    );
  }

  Future<void> registerPhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      profileImageFile.value = File(pickedImage.path);
    }
  }

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final selectedImage = await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      profileImageFile.value = File(selectedImage.path);
    }
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      _createAccount();
    }
  }

  Future<void> _createAccount() async {
    CCDialog.loadingWithText(message: "Seu cadastro está sendo realizado...");

    _authService
        .createAccount(
            email: emailController.text,
            password: passwordController.text,
            name: userNameController.text)
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

  void goToLogin() {
    Get.offAllNamed("/login");
  }

  void goToHome() {
    Get.offAllNamed("/home", arguments: [
      true,
      _userCredential!.user,
      userNameController.text,
      profileImageFile.value.path
    ]);
  }
}
