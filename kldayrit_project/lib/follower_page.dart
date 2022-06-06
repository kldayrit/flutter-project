import 'package:flutter/material.dart';
import 'user_model.dart' as user;

class ShowFollowerPage extends StatefulWidget {
  const ShowFollowerPage({Key? key}) : super(key: key);

  @override
  _ShowFollowerPageState createState() => _ShowFollowerPageState();
}

class _ShowFollowerPageState extends State<ShowFollowerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Followers"),
      ),
      body: ListView.builder(
        itemBuilder: (context, int index) {
          final follow = user.followers[index];
          return Center(
            child: ListTile(
              title: Text(follow.username),
            ),
          );
        },
        itemCount: user.followers.length,
      ),
    );
  }
}
