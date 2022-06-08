import 'package:flutter/material.dart';
import 'self_post.dart';
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
                  check =
                      await user.getFollower(); // to update list of followers
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
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Container(
                        height: 50.0,
                        child: const Center(
                          child: Text(
                            'Unable to Follow User\n Unfollow someone or Try Again Later',
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
              onPressed: () async {
                for (var i = 0; i < user.followers.length; i++) {
                  if (user.view == user.followers[i].username) {
                    user.check = true;
                  } else {
                    user.check = false;
                  }
                }
                if (user.check) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShowSelfPostPage()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Container(
                        height: 50.0,
                        child: const Center(
                          child: Text(
                            'You are not friends with this User\n Follow them to be Friends',
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
              icon: const Icon(Icons.remove_red_eye_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
