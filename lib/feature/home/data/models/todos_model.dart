// To parse this JSON data, do
//
//     final todosModel = todosModelFromJson(jsonString);

import 'dart:convert';

TodosModel todosModelFromJson(String str) =>
    TodosModel.fromJson(json.decode(str));

String todosModelToJson(TodosModel data) => json.encode(data.toJson());

class TodosModel {
  int statusCode;
  List<TodoData> data;
  String message;
  bool success;

  TodosModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory TodosModel.fromJson(Map<String, dynamic> json) => TodosModel(
        statusCode: json["statusCode"],
        data:
            List<TodoData>.from(json["data"].map((x) => TodoData.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class TodoData {
  int userId;
  int id;
  String title;
  bool completed;

  TodoData({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TodoData.fromJson(Map<String, dynamic> json) => TodoData(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
