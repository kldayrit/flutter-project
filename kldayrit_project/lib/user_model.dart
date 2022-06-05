import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

//global variable for token
String token = "empty";
List<Post> posts = [];
String pagination = '';
String user = '';
String last = '';
String first = '';

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

Future<int> getUser() async {
  final response = await http.get(
    Uri.parse('https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/user/$user'),
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
    body:
        jsonEncode(<String, String>{'text': text, 'public': public.toString()}),
  );

  if (response.statusCode == 200) {}
  return response.statusCode;
}
