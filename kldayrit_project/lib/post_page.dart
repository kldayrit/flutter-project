import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kldayrit_project/management_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'user_model.dart' as user;
import 'post_model.dart';
import 'create_post.dart';
import 'self_post.dart';
import 'view_profile.dart';

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
          icon: const Icon(Icons.align_horizontal_right),
          onPressed: () {
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ShowManagementPage()));
            },
            icon: const Icon(
              Icons.account_box,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ShowViewProfilePage()));
                        } else {
                          int check = await user.getUser(user.user);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ShowManagementPage()));
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
                      Icons.account_tree,
                      size: 25,
                    ),
                    onPressed: () {},
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
