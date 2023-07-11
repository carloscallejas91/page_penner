import "package:get/get.dart";
import "package:page_penner/data/services/auth/auth_service.dart";

class SplashScreenController extends GetxController {
  // services
  final AuthService _authService = AuthService();

  @override
  void onInit() {
    _isOnline();
    super.onInit();
  }

  Future<void> _isOnline() async {
    if (await _authService.userIsLoggedIn() != null) goToHome();
  }

  void goToNewAccount() {
    Get.offAllNamed("/new_account");
  }

  void goToLogin() {
    Get.offAllNamed("/login");
  }

  void goToHome() {
    Get.offAllNamed("/home");
  }
}
