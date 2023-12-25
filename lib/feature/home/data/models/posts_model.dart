// To parse this JSON data, do
//
//     final postsModel = postsModelFromJson(jsonString);

import 'dart:convert';

PostsModel postsModelFromJson(String str) =>
    PostsModel.fromJson(json.decode(str));

String postsModelToJson(PostsModel data) => json.encode(data.toJson());

class PostsModel {
  int statusCode;
  List<PostDatum> data;
  String message;
  bool success;

  PostsModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        statusCode: json["statusCode"],
        data: List<PostDatum>.from(
            json["data"].map((x) => PostDatum.fromJson(x))),
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

class PostDatum {
  int userId;
  int id;
  String title;
  String body;

  PostDatum({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostDatum.fromJson(Map<String, dynamic> json) => PostDatum(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
