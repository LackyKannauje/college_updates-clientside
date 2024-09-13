class PostModel {
  final String postId;
  final String userId;
  final String title;
  final String description;
  final int likes;
  final String uploadTime;
  final List media;
  final List comments;

  PostModel({
    required this.postId,
    required this.userId,
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
      userId: json['user'],
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
