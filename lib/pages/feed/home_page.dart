import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/my_widgets/post/list_post.dart';
import 'package:facebook_app/pages/feed/post/add_post.dart';
import 'package:facebook_app/services/feed_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../services/app_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  late int index;
  static const int count = 10;
  bool isEnd = false;
  bool isLoading = false;
  List<Post> posts = [];
  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0) {
      fetchFeed(context);
    }
  }

  void fetchFeed(BuildContext context) async {
    if (!isEnd) {
      setState(() {
        isLoading = true;
      });
      try {
        final fetchData = await FeedService(context: context)
            .getFeeds(index: index, count: count);

        if (fetchData.isEmpty) {
          setState(() {
            isEnd = true;
          });
        } else {
          setState(() {
            posts.addAll(fetchData);
            index = index + count;
          });
        }
      } catch (err) {
        debugPrint("exception $err");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    index = 0;
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    fetchFeed(context);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFc9ccd1), width: 5)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.push(
                      "/authenticated/personalPage/${appService.uidLoggedIn}");
                },
                child: MyImage(
                  imageUrl: appService.avatar,
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: OutlinedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) =>  PostPage()),
                  // );
                  context.push('/authenticated/addPost');
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: const StadiumBorder(),
                ),
                child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Bạn đang nghĩ gì?",
                      style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w400),
                    )),
              ))
            ],
          ),
        ),
        ListPost(
            posts: posts,
            scrollController: _scrollController,
            isLoading: isLoading)
      ],
    ));
  }
}