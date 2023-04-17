import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:page_penner/app/modules/home/controllers/home_controller.dart";
import "package:page_penner/core/values/strings.dart";

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(titleApplication),
      ),
      body: Container(),
    );
  }
}
