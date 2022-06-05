import 'dart:convert';
import 'package:http/http.dart' as http;

//global variable for token
String token = "empty";
late List<dynamic> test;

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
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // parse  json data to map
    var jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    // get the value of the data key from the map
    var data = jsonData['data'] as Map<String, dynamic>;
    // get the value of the token key from data
    token = data['token'];
  }
  return response.statusCode;
}

Future<int> getallPost() async {
  final response = await http.get(
      Uri.parse('https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/post'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token,
      });

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // parse  json data to map
    var jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    // get the value of the token key from data
    test = jsonData['data'] as List<dynamic>;
  }
  return response.statusCode;
}
