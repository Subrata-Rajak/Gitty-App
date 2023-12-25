class CommentEntity {
  int statusCode;
  List<CommentsDataEntity> data;
  String message;
  bool success;

  CommentEntity({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });
}

class CommentsDataEntity {
  int postId;
  int id;
  String name;
  String email;
  String body;

  CommentsDataEntity({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });
}
