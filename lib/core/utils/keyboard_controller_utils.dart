import "dart:async";

import "package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart";
import "package:get/get.dart";

class KeyboardController extends GetxController {
  final KeyboardVisibilityController _keyboardVisibilityController =
      KeyboardVisibilityController();
  final RxBool isKeyboardVisible = false.obs;

  late StreamSubscription<bool> keyboardSubscription;

  @override
  void onInit() {
    keyboardSubscription =
        _keyboardVisibilityController.onChange.listen((bool visible) {
      isKeyboardVisible.value = visible;
    });
    super.onInit();
  }


  @override
  void onClose() {
    keyboardSubscription.cancel();
    super.onClose();
  }
}
