import 'package:flutter/material.dart';
import 'package:kldayrit_project/create_post.dart';
import 'user_model.dart' as user;
import 'post_model.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'management_page.dart';
import 'comment_page.dart';
import 'edit_post.dart';

class ShowSelfPostPage extends StatefulWidget {
  const ShowSelfPostPage({Key? key}) : super(key: key);

  @override
  _ShowSelfPostPageState createState() => _ShowSelfPostPageState();
}

class _ShowSelfPostPageState extends State<ShowSelfPostPage> {
  String id = ''; // get the id of the last from the list to put on next
  List<Post> posts = []; // list of post
  String self = user.user;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true); // refresh controller

  // this method is inside this because we want to use setState()
  Future<bool> getallPost({bool isRefresh = false}) async {
    if (isRefresh) {
      id = '';
    }
    final response = await http.get(
        Uri.parse(
            'https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/post?limit=10&next=$id&username=$self'),
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
        title: const Text("Own Posts"),
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
            return Column(
              children: [
                ListTile(
                  title: TextButton(
                    onPressed: () async {
                      int check = await user.getUser(user.user);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ShowManagementPage()));
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        post.username,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(post.text),
                  ),
                  leading: Wrap(
                    spacing: -40,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.comment,
                          size: 25,
                        ),
                        onPressed: () {
                          user.post = post.id;
                          user.title = post.username;
                          user.subtitle = post.text;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ShowCommentPage()));
                        },
                      ),
                      Container(
                        child: Text(
                          post.public ? 'Public' : 'Private',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  trailing: Wrap(
                    spacing: 0, // space between two icons
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          user.post = post.id;
                          user.title = post.public ? 'public' : 'private';
                          user.subtitle = post.text;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ShowPostEditPage()));
                        },
                        icon: const Icon(Icons.edit),
                      ), // icon-1
                      IconButton(
                        onPressed: () async {
                          user.post = post.id;
                          int check = await user.deletePost();
                          Navigator.pop(context); // pop current page
                          //pushes second page again
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ShowSelfPostPage()));
                        },
                        icon: const Icon(Icons.delete),
                      ), // icon-2
                    ],
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
