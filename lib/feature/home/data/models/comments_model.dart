// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

CommentsModel commentsModelFromJson(String str) =>
    CommentsModel.fromJson(json.decode(str));

String commentsModelToJson(CommentsModel data) => json.encode(data.toJson());

class CommentsModel {
  int statusCode;
  List<CommentsData> data;
  String message;
  bool success;

  CommentsModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        statusCode: json["statusCode"],
        data: List<CommentsData>.from(
            json["data"].map((x) => CommentsData.fromJson(x))),
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

class CommentsData {
  int postId;
  int id;
  String name;
  String email;
  String body;

  CommentsData({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentsData.fromJson(Map<String, dynamic> json) => CommentsData(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };
}
