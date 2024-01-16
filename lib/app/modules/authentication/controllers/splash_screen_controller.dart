import "package:firebase_auth/firebase_auth.dart";
import "package:get/get.dart";
import "package:page_penner/data/services/auth/auth_service.dart";

class SplashScreenController extends GetxController {
  // services
  final AuthService _authService = AuthService();
  late User? _user;

  @override
  void onInit() {
    _isOnline();
    super.onInit();
  }

  Future<void> _isOnline() async {
    _user = await _authService.userIsLoggedIn();
    if (_user != null) goToMain();
  }

  void goToNewAccount() {
    Get.offAllNamed("/new_account");
  }

  void goToLogin() {
    Get.offAllNamed("/login");
  }

  void goToMain() {
    Get.offAllNamed("/main", arguments: [_user, 0]);
  }
}
