import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/post/feed_item.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListPost extends StatelessWidget {
  final List<Post> posts;
  final bool isEnd;
  final ScrollController scrollController;
  final bool isLoading;
  const ListPost(
      {super.key,
      required this.posts,
      required this.scrollController,
      required this.isLoading,
      required this.isEnd});

  @override
  Widget build(BuildContext context) {
    return posts.isEmpty && isEnd
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
                        if (index == posts.length) {
                          if (isEnd) return Container();
                          return Expanded(
                            child: Skeletonizer(
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      height: 6,
                                      width: double.infinity,
                                      color: Colors.black12,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: 44,
                                                  height: 44,
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 44,
                                                  )),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 80,
                                                      height: 12,
                                                      color: Colors.black26,
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: 50,
                                                      height: 8,
                                                      color: Colors.black26,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 28,
                                    ),
                                    AspectRatio(
                                      aspectRatio: 4 / 3,
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        color: Colors.white12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 6, color: Colors.black12))),
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: FeedItem(
                            postData: posts[index],
                          ),
                        );
                      },
                      itemCount: posts.length + 1)),
            ],
          ));
  }
}
