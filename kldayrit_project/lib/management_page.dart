import 'package:flutter/material.dart';
import 'user_model.dart' as user;

class ShowManagementPage extends StatefulWidget {
  const ShowManagementPage({Key? key}) : super(key: key);

  @override
  _ShowManagementPageState createState() => _ShowManagementPageState();
}

class _ShowManagementPageState extends State<ShowManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('propayl'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                user.user,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                user.first,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                user.last,
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
              child: const Text(
                'LOGOUT',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                int check = await user.logoutUser();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            )
          ],
        ),
      ),
    );
  }
}
