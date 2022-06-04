import 'package:flutter/material.dart';
import 'user_model.dart' as user;

class ShowPostPage extends StatefulWidget {
  const ShowPostPage({Key? key}) : super(key: key);

  @override
  _ShowPostPageState createState() => _ShowPostPageState();
}

class _ShowPostPageState extends State<ShowPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.list),
            tooltip: 'My Profile',
          )
        ],
      ),
      body: Text(user.token.toString()),
    );
  }
}
