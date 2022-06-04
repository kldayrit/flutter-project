import 'dart:convert';

import 'package:flutter/material.dart';
//import necessary packages
import 'package:http/http.dart' as http;

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
