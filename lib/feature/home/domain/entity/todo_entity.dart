class TodoEntity {
  int statusCode;
  List<TodoDataEntity> data;
  String message;
  bool success;

  TodoEntity({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });
}

class TodoDataEntity {
  int userId;
  int id;
  String title;
  bool completed;

  TodoDataEntity({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });
}
