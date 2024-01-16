import "package:flutter/material.dart";

class ProfileAvatarWidget extends StatelessWidget {
  final String? photoUrl;

  const ProfileAvatarWidget({Key? key, this.photoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return photoUrl != null
        ? CircleAvatar(
            radius: 32,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(photoUrl!),
              backgroundColor: Colors.transparent,
            ),
          )
        : CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            radius: 30,
            child: Icon(
              Icons.camera_alt_outlined,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          );
  }
}
