import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kldayrit_project/management_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'user_model.dart' as user;
import 'post_model.dart';
import 'create_post.dart';
import 'self_post.dart';
import 'view_profile.dart';
import 'comment_page.dart';

class ShowPostPage extends StatefulWidget {
  const ShowPostPage({Key? key}) : super(key: key);

  @override
  _ShowPostPageState createState() => _ShowPostPageState();
}

class _ShowPostPageState extends State<ShowPostPage> {
  String id = ''; // get the id of the last from the list to put on next
  List<Post> posts = []; // list of post
  final RefreshController refreshController =
      RefreshController(initialRefresh: true); // refresh controller

  // this method is inside this because we want to use setState()
  Future<bool> getallPost({bool isRefresh = false}) async {
    if (isRefresh) {
      id = '';
    }
    final response = await http.get(
        Uri.parse(
            'https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/post?limit=40&next=$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + user.token,
        });

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // parse  json data to map
      final result = postDataFromJson(response.body);

      if (isRefresh) {
        posts = result.data;
      } else {
        posts.addAll(result.data);
      }
      id = result.data[result.data.length - 1].id;
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.chrome_reader_mode),
          onPressed: () {
            user.check = false;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ShowSelfPostPage()));
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              int check = await user.getUser(user.user);
              if (check == 200) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShowManagementPage()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Container(
                      height: 50.0,
                      child: const Center(
                        child: Text(
                          'Unable to Retrieve Data from Server\nRestart the App or Try again later',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.list_alt,
              size: 40,
            ),
            tooltip: 'My Profile',
          )
        ],
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await getallPost(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getallPost();
          if (result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        child: ListView.builder(
          itemBuilder: ((context, index) {
            final post = posts[index];
            if (!post.public) {
              return Container();
            }
            return Column(
              children: [
                ListTile(
                  title: TextButton(
                      onPressed: () async {
                        if (user.user != post.username) {
                          int check = await user.getUser(post.username);
                          user.view = post.username;
                          if (check == 200) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ShowViewProfilePage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Container(
                                  height: 50.0,
                                  child: const Center(
                                    child: Text(
                                      'Unable to Retrieve Data from Server\nRestart the App or Try again later',
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
                        } else {
                          int check = await user.getUser(user.user);
                          if (check == 200) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ShowManagementPage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Container(
                                  height: 50.0,
                                  child: const Center(
                                    child: Text(
                                      'Unable to Retrieve Data from Server\nRestart the App or Try again later',
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
                        }
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          post.username,
                          style: const TextStyle(fontSize: 15),
                        ),
                      )),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(post.text),
                  ),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.comment_outlined,
                      size: 25,
                    ),
                    onPressed: () {
                      user.post = post.id;
                      user.title = post.username;
                      user.subtitle = post.text;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ShowCommentPage()));
                    },
                  ),
                ),
                const Divider()
              ],
            );
          }),
          itemCount: posts.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          user.check = true; // nagsasabi kung saan page gumawa ng post
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ShowPostCreatePage()));
        },
        child: const Icon(Icons.post_add_outlined),
      ),
    );
  }
}
