import 'package:flutter/material.dart';
import 'package:kldayrit_project/update_profile.dart';
import 'user_model.dart' as user;
import 'follower_page.dart';

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
          title: const Text('Profile'),
        ),
        body: ListView(
          children: <Widget>[
            const Divider(
              thickness: 20,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                user.user,
                style: TextStyle(fontSize: 30),
              ),
            ),
            const Divider(
              thickness: 10,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                user.first + ' ' + user.last,
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(
              thickness: 10,
            ),
            TextButton.icon(
              label: const Text(
                'EDIT PROFILE',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShowUpdateProfilePage()));
              },
              icon: const Icon(Icons.edit),
            ),
            TextButton.icon(
              label: const Text(
                'VIEW FOLLOWERS',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                int check = await user.getFollower();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShowFollowerPage()));
              },
              icon: const Icon(Icons.remove_red_eye_outlined),
            ),
            TextButton(
              child: const Text(
                'LOGOUT',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                int check = await user.logoutUser();
                //pop pushed pages until you get to the login page
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
