import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'user_model.dart' as user;
import 'post_model.dart';

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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.list),
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

            return ListTile(
              title: Text(post.text),
            );
          }),
          itemCount: posts.length,
        ),
      ),
    );
  }
}
