import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:page_penner/core/theme/app_theme.dart";
import "package:page_penner/core/values/strings.dart";
import "package:page_penner/routes/app_pages.dart";
import "package:page_penner/routes/app_routes.dart";

class PagePennerApp extends StatelessWidget {
  const PagePennerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: titleApplication,
      debugShowCheckedModeBanner: false,
      theme: CustomThemeData.lightTheme,
      getPages: AppPage.routes,
      initialRoute: Routes.SPLASH_SCREEN,
    );
  }
}
