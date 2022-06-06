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
              trailing: IconButton(
                icon: const Icon(Icons.delete_forever_sharp),
                onPressed: () async {
                  int check = await user.removeFollow(follow.username);
                  if (check == 200) {
                    //display success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.blue,
                        content: Container(
                          height: 50.0,
                          child: const Center(
                            child: Text(
                              'SUCCESSFULLY UNFOLLOWED USER',
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
              ),
            ),
          );
        },
        itemCount: user.followers.length,
      ),
    );
  }
}
