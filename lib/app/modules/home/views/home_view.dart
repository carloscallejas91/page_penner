import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:google_nav_bar/google_nav_bar.dart";
import "package:line_icons/line_icons.dart";
import "package:page_penner/app/modules/home/controllers/home_controller.dart";
import "package:page_penner/core/values/strings.dart";

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondaryContainer,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              textStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              rippleColor: Theme.of(context).colorScheme.tertiary,
              hoverColor: Theme.of(context).colorScheme.onTertiary,
              gap: 8,
              activeColor: Theme.of(context).colorScheme.onPrimary,
              iconSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 500),
              tabBackgroundColor: Theme.of(context).colorScheme.primary,
              color: Theme.of(context).colorScheme.secondary,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: "Início",
                ),
                GButton(
                  icon: LineIcons.bookOpen,
                  text: "Meus livros",
                ),
                GButton(
                  icon: LineIcons.bookmark,
                  text: "Metas de leitura",
                ),
                GButton(
                  icon: LineIcons.user,
                  text: "Perfil",
                ),
              ],
              selectedIndex: controller.selectedIndex.value,
              onTabChange: (index) {
                controller.selectedIndex.value = index;
              },
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundAboutBook),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Obx(
            () => controller.widgetOptions
                .elementAt(controller.selectedIndex.value),
          ),
        ),
      ),
    );
  }
}
