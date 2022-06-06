import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

//global variable for user details
String token = "empty";
String user = '';
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
