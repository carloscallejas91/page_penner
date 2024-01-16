import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:page_penner/app/modules/main/controllers/main_controller.dart';
import 'package:page_penner/app/modules/main/widgets/profile_header_widget.dart';
import 'package:page_penner/core/values/strings.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GNav(
              textStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              rippleColor: Theme.of(context).colorScheme.secondary,
              hoverColor: Theme.of(context).colorScheme.tertiary,
              activeColor: Theme.of(context).colorScheme.onPrimaryContainer,
              tabBackgroundColor: Theme.of(context).colorScheme.primary,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              gap: 8,
              iconSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 500),
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: "Início",
                ),
                GButton(
                  icon: LineIcons.bookmark,
                  text: "Meus livros",
                ),
                GButton(
                  icon: LineIcons.book,
                  text: "Para ler",
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
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundAboutBook),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const ProfileHeaderWidget(),
            Obx(() => controller.widgetOptions.elementAt(controller.selectedIndex.value)),
          ],
        ),
      ),
    );
  }
}
