import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/post/feed_item.dart';
import 'package:flutter/material.dart';

class ListPost extends StatelessWidget {
  final List<Post> posts;
  final ScrollController scrollController;
  final bool isLoading;
  final VoidCallback refreshPosts;
  const ListPost(
      {super.key,
      required this.posts,
      required this.scrollController,
      required this.isLoading,
      required this.refreshPosts});

  @override
  Widget build(BuildContext context) {
    return posts.isEmpty
        ? const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(child: Text("Không có bài viết nào")),
          )
        : Expanded(
            child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      controller: scrollController,
                      itemBuilder: (_, index) {
                        return Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 4, color: Colors.grey))),
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: FeedItem(
                            postData: posts[index],
                            refresh: refreshPosts,
                          ),
                        );
                      },
                      itemCount: posts.length)),
              if (isLoading) const CircularProgressIndicator()
            ],
          ));
  }
}
