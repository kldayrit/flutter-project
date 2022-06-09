import 'package:flutter/material.dart';
import 'self_post.dart';
import 'user_model.dart' as user;

class ShowPostEditPage extends StatefulWidget {
  const ShowPostEditPage({Key? key}) : super(key: key);

  @override
  _ShowPostEditPageState createState() => _ShowPostEditPageState();
}

class _ShowPostEditPageState extends State<ShowPostEditPage> {
  String _dropdownvalue = user.title;
  var option = [
    'public',
    'private',
  ];
  TextEditingController textController =
      TextEditingController(text: user.subtitle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Post'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(10),
              child: DropdownButton(
                iconSize: 50,
                value: _dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: option.map((String option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(
                      option,
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      _dropdownvalue = newValue!;
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Type your post here...',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('EDIT POST'),
                onPressed: () async {
                  int check = await user.updatePost(
                      textController.text, _dropdownvalue);
                  if (check == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.blue,
                        content: Container(
                          height: 50.0,
                          child: const Center(
                            child: Text(
                              'Pull up to Refresh to See post',
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
                              'Failed to Edit Post\nRestart the App or Try again later',
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
                  Navigator.pop(context);
                  //pushes second page again
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShowSelfPostPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
