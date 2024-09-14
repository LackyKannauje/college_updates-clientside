class ProfileModel {
  final String id;
  final String username;
  final String profilePicture;
  final String bio;
  final List followers;
  final List following;

  ProfileModel({
    required this.id,
    required this.username,
    required this.profilePicture,
    required this.bio,
    required this.followers,
    required this.following,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'],
      username: json['username'],
      profilePicture: json['profilePicture'] ?? '',
      bio: json['bio'] ?? '',
      followers: json['followers'],
      following: json['following'],
    );
  }
}
