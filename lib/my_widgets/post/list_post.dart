import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/post/feed_item.dart';
import 'package:flutter/material.dart';

class ListPost extends StatefulWidget {
  final List<Post> posts;
  final ScrollController scrollController;
  final bool isLoading;
  const ListPost({super.key, required this.posts, required this.scrollController, required this.isLoading});

  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  @override
  Widget build(BuildContext context) {
    return widget.posts.isEmpty
        ? const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(child: Text("Không có bài viết nào")),
          )
        : Expanded(
            child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      controller: widget.scrollController,
                      itemBuilder: (_, index) {
                        return Container(
                          decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 3, color: Colors.grey))),
                          padding: const EdgeInsets.only(top: 10),
                          margin: const EdgeInsets.only(bottom: 10,),
                          child: FeedItem(
                            postData: widget.posts[index],
                          ),
                        );
                      },
                      itemCount: widget.posts.length)),
              if (widget.isLoading) const CircularProgressIndicator()
            ],
          ));
  }
}