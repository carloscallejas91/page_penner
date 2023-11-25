import "package:flutter/material.dart";
import "package:page_penner/core/application/app_dependencies.dart";
import "package:page_penner/core/application/page_penner_app.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // dependencies
  AppDependencies.initialize();

  // services
  await AppDependencies.initializeAsync();

  runApp(const PagePennerApp());
}
