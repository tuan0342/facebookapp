import 'dart:convert';

import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/my_widgets/post/list_post.dart';
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
  int? lastId;
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
    debugPrint("fetchFeed");
    if (!isEnd) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await FeedService(context: context)
            .getFeeds(index: index, count: count, lastId: lastId);

        debugPrint("response: ${response.toString()}");

        if (response["feed"].isEmpty) {
          if (posts.isEmpty) {
            setState(() {
              posts.addAll(
                  Provider.of<AppService>(context, listen: false).feedCache);
            });
          }
          if (response["isSuccess"] == true) {
            setState(() {
              isEnd = true;
            });
          }
        } else {
          if (posts.isEmpty) {
            // ignore: use_build_context_synchronously
            Provider.of<AppService>(context, listen: false).feedCache =
                response["feed"];
          }
          setState(() {
            posts.addAll(response["feed"]);
            debugPrint("${posts[1].toJson().toString()}");
            lastId = response["last_id"];
            index = index + count;
            isLoading = false;
          });
        }
      } catch (err) {
        debugPrint("exception $err");
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

  Future refresh() async {
    setState(() {
      isLoading = false;
      isEnd = false;
      index = 0;
      posts = [];
      lastId = null;
    });
    fetchFeed(context);
  }

  void _onReportItem(int postId) {
    setState(() {
      posts.retainWhere((post) => post.id != postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: refresh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xFFc9ccd1), width: 5)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.push(
                        "/authenticated/personalPage/${appService.uidLoggedIn}").then((value) => refresh());
                  },
                  child: Selector<AppService, String>(
                            selector: (_, notifier) =>
                                notifier.avatar,
                            builder: (_, value, __) => MyImage(
                              imageUrl: appService.avatar,
                              height: 40,
                              width: 40),),
                  // MyImage(
                  //   imageUrl: appService.avatar,
                  //   width: 40,
                  //   height: 40,
                  // ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: OutlinedButton(
                  onPressed: () {
                    context.push("/authenticated/addPost").then((value) => refresh());
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
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )),
                ))
              ],
            ),
          ),
          ListPost(
            posts: posts,
            isEnd: isEnd,
            scrollController: _scrollController,
            isLoading: isLoading,
            refreshPosts: refresh,
            onReportItem: _onReportItem,
          )
        ],
      ),
    ));
  }
}
