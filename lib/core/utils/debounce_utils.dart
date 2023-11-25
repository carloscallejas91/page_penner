import "dart:async";

import "package:flutter/material.dart";

class DebounceUtils {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  DebounceUtils({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
