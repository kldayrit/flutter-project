import 'package:flutter/material.dart';
import 'user_model.dart' as user;

class ShowViewProfilePage extends StatefulWidget {
  const ShowViewProfilePage({Key? key}) : super(key: key);

  @override
  _ShowViewProfilePageState createState() => _ShowViewProfilePageState();
}

class _ShowViewProfilePageState extends State<ShowViewProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.view + '\'s Profile'),
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
                user.view,
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
                'FOLLOW',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                int check = await user.followUser(user.view);
                if (check == 200) {
                  //display success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.blue,
                      content: Container(
                        height: 50.0,
                        child: const Center(
                          child: Text(
                            'Successfuly Followed User',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.star_border_purple500),
            ),
            TextButton.icon(
              label: const Text(
                'VIEW POSTS',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {},
              icon: const Icon(Icons.remove_red_eye_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
