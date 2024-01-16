import 'package:page_penner/data/models/profile_user.dart';

class ProfileUpdateRequest {
  final ProfileUser profile;

  ProfileUpdateRequest({
    required this.profile,
  });

  Map<String, dynamic> toJson() => {
        "name": profile.name,
        "email": profile.email,
        "photo_url": profile.photoUrl,
        "create_in": profile.createIn,
        "last_login": profile.lastLogin,
      };
}
