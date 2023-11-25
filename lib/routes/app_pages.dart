import "package:get/get.dart";
import "package:page_penner/app/modules/authentication/bindings/forget_password_binding.dart";
import "package:page_penner/app/modules/authentication/bindings/login_binding.dart";
import "package:page_penner/app/modules/authentication/bindings/new_account_binding.dart";
import "package:page_penner/app/modules/authentication/bindings/splash_screen_binding.dart";
import "package:page_penner/app/modules/authentication/views/forget_password_view.dart";
import "package:page_penner/app/modules/authentication/views/login_view.dart";
import "package:page_penner/app/modules/authentication/views/new_account_view.dart";
import "package:page_penner/app/modules/authentication/views/splash_screen_view.dart";
import "package:page_penner/app/modules/home/bindings/home_binding.dart";
import "package:page_penner/app/modules/home/views/home_view.dart";
import "package:page_penner/app/modules/volume_information/bindings/book_information_binding.dart";
import "package:page_penner/app/modules/volume_information/bindings/my_book_binding.dart";
import "package:page_penner/app/modules/volume_information/views/book_information_view.dart";
import "package:page_penner/app/modules/volume_information/views/my_book_view.dart";
import "package:page_penner/routes/app_routes.dart";

class AppPage {
  AppPage._();

  static final List<GetPage> routes = <GetPage>[
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: Routes.NEW_ACCOUNT,
      page: () => const NewAccountView(),
      binding: NewAccountBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.BOOK_INFORMATION,
      page: () => const BookInformationView(),
      binding: BookInformationWishListBinding(),
    ),
    GetPage(
      name: Routes.MY_BOOK,
      page: () => const MyBookView(),
      binding: MyBookBinding(),
    ),
  ];
}
