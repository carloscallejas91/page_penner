import "package:firebase_auth/firebase_auth.dart";
import "package:get/get.dart";
import "package:page_penner/app/widgets/snack_bar/cc_snack_bar.dart";
import "package:page_penner/data/services/realtime_database/request/user_profile_update_request.dart";
import "package:page_penner/data/services/realtime_database/user_profile_service.dart";
import "package:page_penner/data/services/storage/storage_service.dart";

class HomeController extends GetxController {
  // services
  final UserProfileService _profileUserService = UserProfileService();
  final StorageService _storageService = StorageService();

  // User
  late UserCredential _userCredential;

  // Additional User Info
  String? userName;
  String? photoURL;
  String? photoUrlDownload;

  // Conditionals
  bool? firstLogin;

  @override
  void onInit() {
    // _authService.logout();
    isTheFirstLogin();
    super.onInit();
  }

  void isTheFirstLogin() {
    if (Get.arguments != null) {
      firstLogin = Get.arguments[0] as bool;
      _userCredential = Get.arguments[1] as UserCredential;
      userName = Get.arguments[2] as String;
      photoURL = Get.arguments[3] as String;
      completeRegistration();
    }
  }

  Future<void> completeRegistration() async {
    if (photoURL!.isNotEmpty) {
      await _uploadPhotoProfile();
    } else {
      await _addAdditionalUserInfo();
    }
  }

  Future<void> _uploadPhotoProfile() async {
    CCSnackBar.info(message: "Iniciando envio da foto de perfil...");
    _storageService
        .uploadPicture(
            path: photoURL!,
            reference: "images/user/${_userCredential.user?.uid}",
            name: DateTime.now().toIso8601String())
        .then((value) {
      if (value.$1 != null) {
        photoUrlDownload = value.$1;
        CCSnackBar.success(message: value.$2);
        _addAdditionalUserInfo();
      } else {
        CCSnackBar.error(message: value.$2);
      }
    });
  }

  Future<void> _addAdditionalUserInfo() async {
    CCSnackBar.info(
        message: "Atualizando informações na base de autenticação...");
    try {
      await _userCredential.user?.updateDisplayName(userName);
      await _userCredential.user?.updatePhotoURL(photoUrlDownload ?? "");
      await _userCredential.user?.reload();

      CCSnackBar.success(message: "Informações do perfil atualizada.");
      _updateProfile();
    } on FirebaseException catch (e) {
      CCSnackBar.error(message: "${e.message}");
    } catch (e) {
      CCSnackBar.error(
          message:
              "Ocorreu um erro ao tentar atualizar as informações adicionais. $e");
    }
  }

  Future<void> _updateProfile() async {
    CCSnackBar.info(
        message: "Concluindo registro de informações adicionais...");
    final request = _createProfileUpdateRequest();

    _profileUserService
        .updateProfileUser(
            path: "users/${_userCredential.user?.uid}", request: request)
        .then((value) {
      if (value.$2 == true) {
        CCSnackBar.success(message: "${value.$1}");
      } else {
        CCSnackBar.error(message: "${value.$1}");
      }
    });
  }

  UserProfileUpdateRequest _createProfileUpdateRequest() {
    final credential = FirebaseAuth.instance.currentUser;
    return UserProfileUpdateRequest(
      name: "${credential?.displayName}",
      email: "${credential?.email}",
      photoUrl: "${credential?.photoURL}",
      createIn: "${credential?.metadata.creationTime}",
      lastLogin: "${credential?.metadata.lastSignInTime}",
    );
  }
}
