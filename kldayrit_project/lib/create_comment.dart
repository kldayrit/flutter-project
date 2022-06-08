import 'package:flutter/material.dart';
import 'user_model.dart' as user;

class ShowCommentCreatePage extends StatefulWidget {
  const ShowCommentCreatePage({Key? key}) : super(key: key);

  @override
  _ShowCommentCreatePageState createState() => _ShowCommentCreatePageState();
}

class _ShowCommentCreatePageState extends State<ShowCommentCreatePage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Type your comment here...',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('COMMENT'),
                onPressed: () async {
                  int check = await user.createComment(textController.text);
                  if (check == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.blue,
                        content: Container(
                          height: 50.0,
                          child: const Center(
                            child: Text(
                              'Comment Created \n Pull up to Refresh to See Comment',
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
                              'Failed to Create Comment\nRestart the App or Try again later',
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
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
