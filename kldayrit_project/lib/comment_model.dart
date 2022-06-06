// To parse this JSON data, do
//
//     final CommentData = CommentDataFromJson(jsonString);

import 'dart:convert';

CommentData commentDataFromJson(String str) =>
    CommentData.fromJson(json.decode(str));

String commentDataToJson(CommentData data) => json.encode(data.toJson());

class CommentData {
  bool success;
  List<Comment> data;

  CommentData({
    required this.success,
    required this.data,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        success: json["success"],
        data: List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Comment {
  String id;
  String text;
  String postId;
  String username;
  int date;

  Comment({
    required this.id,
    required this.text,
    required this.postId,
    required this.username,
    required this.date,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        text: json["text"],
        postId: json["postId"],
        username: json["username"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "postId": postId,
        "username": username,
        "date": date,
      };
}
