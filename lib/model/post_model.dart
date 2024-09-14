class PostModel {
  final String postId;
  final User user;
  final String title;
  final String description;
  final int likes;
  final String uploadTime;
  final List media;
  final List comments;

  PostModel({
    required this.postId,
    required this.user,
    required this.title,
    required this.description,
    required this.likes,
    required this.uploadTime,
    required this.media,
    required this.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['_id'],
      user: User.fromJson(json['user']),
      title: json['title'],
      description: json['description'],
      likes: json['likes'],
      uploadTime: json['createdAt'],
      media: json['media'],
      comments: json['comments'] ?? [],
    );
  }

  static List<PostModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PostModel.fromJson(json)).toList();
  }
}

class User {
  final String id;
  final String username;
  final String profilePicture;
  final String bio;

  User({
    required this.id,
    required this.username,
    required this.profilePicture,
    required this.bio,
  });

  // Factory method to parse JSON into User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      profilePicture: json['profilePicture'],
      bio: json['bio'],
    );
  }
}
