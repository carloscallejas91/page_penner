class UserProfileUpdateRequest {
  final String name;
  final String email;
  final String photoUrl;
  final String createIn;
  final String lastLogin;

  UserProfileUpdateRequest({
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.createIn,
    required this.lastLogin,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "photo_url": photoUrl,
        "create_in": createIn,
        "last_login": lastLogin,
      };
}
