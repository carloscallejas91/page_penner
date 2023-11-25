import "package:flutter/material.dart";
import "package:page_penner/app/modules/home/widgets/profile_avatar_widget.dart";
import "package:page_penner/core/extensions/text_extension.dart";

class ProfileHeaderWidget extends StatelessWidget {
  final String userName;
  final String? photoUrl;

  const ProfileHeaderWidget({Key? key, required this.userName, this.photoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Olá, Bom dia!",
            ).bodyLarge().secondary(context),
            Text(
              userName,
            ).headlineSmall().primary(context).bold(),
          ],
        ),
        ProfileAvatarWidget(photoUrl: photoUrl),
      ],
    );
  }
}
