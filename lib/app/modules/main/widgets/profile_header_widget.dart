import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:page_penner/app/modules/main/controllers/main_controller.dart";
import "package:page_penner/app/modules/main/widgets/profile_avatar_widget.dart";
import "package:page_penner/core/extensions/text_extension.dart";

class ProfileHeaderWidget extends GetView<MainController> {
  const ProfileHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 64, right: 32, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.generateLabel(),
              ).bodyLarge().bold().secondary(context),
              Text(
                controller.user.displayName!,
              ).headlineSmall().primary(context).bold(),
            ],
          ),
          ProfileAvatarWidget(photoUrl: controller.user.photoURL),
        ],
      ),
    );
  }
}
