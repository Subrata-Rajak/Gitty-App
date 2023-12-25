class PostEntity {
  int statusCode;
  List<PostDataEntity> data;
  String message;
  bool success;

  PostEntity({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });
}

class PostDataEntity {
  int userId;
  int id;
  String title;
  String body;

  PostDataEntity({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
}
