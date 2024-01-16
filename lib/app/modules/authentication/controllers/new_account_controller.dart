import "dart:io";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";
import "package:page_penner/app/widgets/dialog/cc_dialog.dart";
import "package:page_penner/app/widgets/snack_bar/cc_snack_bar.dart";
import "package:page_penner/core/utils/validate_entry_utils.dart";
import "package:page_penner/data/models/profile_user.dart";
import "package:page_penner/data/services/auth/auth_service.dart";
import "package:page_penner/data/services/realtime_database/profile_service.dart";
import "package:page_penner/data/services/realtime_database/request/profile_update_request.dart";
import "package:page_penner/data/services/storage/storage_service.dart";

class NewAccountController extends GetxController {
  // services
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();
  final ProfileService _profileService = ProfileService();

  // User
  UserCredential? _credential;

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

  // Image
  Rx<File> imagePath = File("").obs;
  late String imageUrl;

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
      contentText: "Escolha uma das opções para selecionar sua imagem de perfil.",
      nameNeutralButton: "Ligar câmera",
      colorNeutralButton: Theme.of(context).colorScheme.primary,
      onPressedNeutralButton: () {
        CCDialog.closeDialog();
        _registerPhoto();
      },
      nameNegativeButton: "Escolher imagem",
      colorNegativeButton: Theme.of(context).colorScheme.primary,
      onPressedNegativeButton: () {
        CCDialog.closeDialog();
        _selectImage();
      },
      namePositiveButton: "Cancelar",
      colorPositiveButton: Theme.of(context).colorScheme.outline,
      onPressedPositiveButton: CCDialog.closeDialog,
    );
  }

  Future<void> _registerPhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      imagePath.value = File(pickedImage.path);
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final selectedImage = await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      imagePath.value = File(selectedImage.path);
    }
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      _createAccount();
    }
  }

  Future<void> _createAccount() async {
    CCDialog.loadingWithText(message: "Aguarde enquanto realizamos seu cadastro...");

    _authService.createAccount(email: emailController.text, password: passwordController.text, name: userNameController.text).then((value) {
      _credential = value.$1;
      if (_credential != null) {
        _completeRegistration();
      } else {
        CCDialog.closeDialog();
        CCSnackBar.error(message: value.$2);
      }
    });
  }

  Future<void> _completeRegistration() async {
    if (imagePath.value.path.isNotEmpty) {
      await _uploadPhotoProfile();
    } else {
      await _addAdditionalUserInfo();
    }
  }

  Future<void> _uploadPhotoProfile() async {
    _storageService
        .uploadPicture(path: imagePath.value.path, reference: "images/user/${_credential!.user!.uid}", name: DateTime.now().toIso8601String())
        .then((value) {
      if (value.$1 != null) {
        imageUrl = value.$1!;
        _addAdditionalUserInfo();
      } else {
        CCDialog.closeDialog();
        CCSnackBar.error(message: value.$2);
      }
    });
  }

  Future<void> _addAdditionalUserInfo() async {
    try {
      await _credential!.user!.updateDisplayName(userNameController.text);
      await _credential!.user!.updatePhotoURL(imageUrl ?? "");
      await _credential!.user!.reload();

      _profileUpdate();
    } on FirebaseException catch (e) {
      CCDialog.closeDialog();
      CCSnackBar.error(message: "${e.message}");
    } catch (e) {
      CCDialog.closeDialog();
      CCSnackBar.error(message: "Ocorreu um erro ao tentar atualizar as informações adicionais. $e");
    }
  }

  Future<void> _profileUpdate() async {
    final request = _createProfileUpdateRequest();

    _profileService.updateProfile(path: "users/${_credential!.user!.uid}/profile", request: request).then((value) {
      if (value.$2 == true) {
        CCDialog.closeDialog();
        CCSnackBar.success(message: "${value.$1}");
        goToMain();
      } else {
        CCDialog.closeDialog();
        CCSnackBar.error(message: "${value.$1}");
      }
    });
  }

  ProfileUpdateRequest _createProfileUpdateRequest() {
    final credential = FirebaseAuth.instance.currentUser;
    return ProfileUpdateRequest(
      profile: ProfileUser(
        name: "${credential?.displayName}",
        email: "${credential?.email}",
        photoUrl: "${credential?.photoURL}",
        createIn: "${credential?.metadata.creationTime}",
        lastLogin: "${credential?.metadata.lastSignInTime}",
      ),
    );
  }

  void goToLogin() {
    Get.offAllNamed("/login");
  }

  void goToMain() {
    Get.offAllNamed("/main", arguments: [_credential!.user, 0]);
  }
}
