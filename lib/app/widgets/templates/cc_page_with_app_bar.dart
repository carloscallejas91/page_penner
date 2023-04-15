import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:page_penner/app/widgets/button/cc_icon_button.dart";
import "package:page_penner/core/values/colors.dart";
import "package:page_penner/core/values/keys.dart";

class CCPageWithAppBar extends StatelessWidget {
  final Widget title;
  final Widget? drawer;
  final Function()? onPressedBackButton;
  final List<Widget>? actions;
  final RxBool? isSearch;
  final Widget? searchWidget;
  final Widget? floatingActionButton;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool isScrollEnabled;
  final List<Widget> body;

  CCPageWithAppBar({
    Key? key,
    required this.title,
    this.drawer,
    this.onPressedBackButton,
    this.actions,
    required this.isSearch,
    this.searchWidget,
    this.floatingActionButton,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.isScrollEnabled = true,
    required this.body,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: Obx(
          () => isSearch != null && isSearch!.value == true
              ? searchWidget!
              : title,
        ),
        leading: drawer == null
            ? CCIconButton(
                icon: arrowLeftIcon,
                iconColor: onPrimary,
                iconSize: 24,
                onPressed: onPressedBackButton!,
              )
            : CCIconButton(
                icon: drawerIcon,
                iconColor: onPrimary,
                iconSize: 24,
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
        actions: actions ?? [],
      ),
      drawer: drawer,
      body: isScrollEnabled
          ? Container(
              width: double.infinity,
              height: double.infinity,
              padding: defaultPaddingBody,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: crossAxisAlignment,
                  mainAxisAlignment: mainAxisAlignment,
                  mainAxisSize: MainAxisSize.min,
                  children: body,
                ),
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              padding: defaultPaddingBody,
              child: Column(
                crossAxisAlignment: crossAxisAlignment,
                mainAxisAlignment: mainAxisAlignment,
                mainAxisSize: mainAxisSize,
                children: body,
              ),
            ),
      floatingActionButton:
          floatingActionButton != null ? floatingActionButton! : null,
    );
  }
}
