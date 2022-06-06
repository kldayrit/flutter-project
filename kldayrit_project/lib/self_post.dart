import 'package:flutter/material.dart';
import 'user_model.dart' as user;
import 'post_model.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
                      onPressed: () {},
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
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
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
    );
  }
}
