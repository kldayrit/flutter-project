
import 'dart:convert';

PostData postDataFromJson(String str) => PostData.fromJson(json.decode(str));

String postDataToJson(PostData data) => json.encode(data.toJson());

class PostData {
  bool success;
  List<Post> data;

  PostData({
    required this.success,
    required this.data,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        success: json["success"],
        data: List<Post>.from(json["data"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Post {
  String id;
  String text;
  String username;
  bool public;
  int date;
  int updated;

  Post({
    required this.id,
    required this.text,
    required this.username,
    required this.public,
    required this.date,
    required this.updated,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        text: json["text"],
        username: json["username"],
        public: json["public"],
        date: json["date"],
        updated: json["updated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "username": username,
        "public": public,
        "date": date,
        "updated": updated,
      };
}
