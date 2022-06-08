import 'dart:convert';
import 'package:http/http.dart' as http;

//global variable for user details
String token = "empty";
String user = ''; // id of user that is logged in
//can be updated to view details on another user
String last = '';
String first = '';
//view is for the username of the post you  want to view
String view = '';
//post is id of post itself
String post = '';
//title is username of the post
String title = ''; // will also be used on determining if post is public or not
//subtitle is the text
String subtitle = '';
//check lang if san ginawa post
bool check =
    false; // if true sa list ng lahat ng public post na create if hinde sa list ng sariling post
// gagamitin na rin pang check if finofollow mo yung tao
// for list of followers
List<Follower> followers = [];
// To parse this JSON data, do
//
//     final FollowerData = FollowerDataFromJson(jsonString);

// clas for list of followers
FollowerData followerDataFromJson(String str) =>
    FollowerData.fromJson(json.decode(str));

String followerDataToJson(FollowerData data) => json.encode(data.toJson());

class FollowerData {
  bool success;
  List<Follower> data;

  FollowerData({
    required this.success,
    required this.data,
  });

  factory FollowerData.fromJson(Map<String, dynamic> json) => FollowerData(
        success: json["success"],
        data:
            List<Follower>.from(json["data"].map((x) => Follower.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Follower {
  String username;
  String firstName;
  String lastName;
  int date;
  int updated;

  Follower({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.date,
    required this.updated,
  });

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        username: json["username"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        date: json["date"],
        updated: json["updated"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "date": date,
        "updated": updated,
      };
}

// function to Register User
Future<int> registerUser(
    String firstname, String lastname, String username, String pasword) async {
  final response = await http.post(
    Uri.parse('https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':
          'Bearer Zxi!!YbZ4R9GmJJ!h5tJ9E5mghwo4mpBs@*!BLoT6MFLHdMfUA%'
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': pasword,
      'firstName': firstname,
      'lastName': lastname,
    }),
  );

  return response.statusCode;
}

//functin to Log in User

Future<int> loginUser(String username, String pasword) async {
  final response = await http.post(
    Uri.parse('https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': pasword,
    }),
  );

  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    // get the value of the data key from the map
    var data = jsonData['data'] as Map<String, dynamic>;
    // get the value of the token key from data
    token = data['token'];
    user = username;
  }
  return response.statusCode;
}

// function to get a User
Future<int> getUser(String id) async {
  final response = await http.get(
    Uri.parse('https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/user/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token,
    },
  );

  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    // get the value of the data key from the map
    var data = jsonData['data'] as Map<String, dynamic>;
    first = data['firstName'];
    last = data['lastName'];
  }
  return response.statusCode;
}

// function to logout user
Future<int> logoutUser() async {
  final response = await http.post(
    Uri.parse('https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/logout'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token,
    },
    body: jsonEncode(<String, String>{}),
  );

  if (response.statusCode == 200) {
    token = 'empty';
  }
  return response.statusCode;
}

// function to createpost
Future<int> createPost(String text, String isPublic) async {
  bool public = false;
  if (isPublic == 'public') {
    public = true;
  }
  final response = await http.post(
    Uri.parse('https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/post'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token,
    },
    body: jsonEncode(<String, String>{
      'text': text,
      'public': public.toString(),
    }),
  );

  if (response.statusCode == 200) {}
  return response.statusCode;
}

// function to update profile
Future<int> updateUser(String firstname, String lastname, String oldPassword,
    String newPassword) async {
  final response = await http.put(
    Uri.parse('https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/user/$user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token,
    },
    body: jsonEncode(<String, String>{
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'firstName': firstname,
      'lastName': lastname,
    }),
  );

  return response.statusCode;
}

// function to createpost
Future<int> createComment(String text) async {
  final response = await http.post(
    Uri.parse('https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/comment/$post'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token,
    },
    body: jsonEncode(<String, String>{
      'text': text,
    }),
  );

  if (response.statusCode == 200) {}
  return response.statusCode;
}

//delete a comment on a post
Future<int> deleteComment(String id, String postId) async {
  final response = await http.delete(
    Uri.parse(
        'https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/comment/$postId/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token,
    },
  );

  if (response.statusCode == 200) {}
  return response.statusCode;
}

Future<int> updatePost(String text, String isPublic) async {
  bool public = false;
  if (isPublic == 'public') {
    public = true;
  }
  final response = await http.put(
    Uri.parse('https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/post/$post'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token,
    },
    body: jsonEncode(<String, String>{
      'text': text,
      'public': public.toString(),
    }),
  );

  return response.statusCode;
}

// function to delete post
Future<int> deletePost() async {
  final response = await http.delete(
    Uri.parse('https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/post/$post'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token,
    },
  );

  return response.statusCode;
}

// function to get follower list
Future<int> getFollower() async {
  final response = await http.get(
    Uri.parse(
        'https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/user?friends=true'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token,
    },
  );

  if (response.statusCode == 200) {
    final result = followerDataFromJson(response.body);
    followers = result.data;
  }
  return response.statusCode;
}

//function to follow a user
Future<int> followUser(String id) async {
  final response = await http.post(
    Uri.parse('https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/follow/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token,
    },
    body: jsonEncode(<String, String>{}),
  );

  if (response.statusCode == 200) {}
  return response.statusCode;
}

Future<int> removeFollow(String id) async {
  final response = await http.delete(
    Uri.parse('https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/follow/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token,
    },
    body: jsonEncode(<String, String>{}),
  );

  if (response.statusCode == 200) {}
  return response.statusCode;
}
