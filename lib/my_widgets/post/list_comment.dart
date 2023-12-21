import 'package:facebook_app/models/mark_comment_model.dart';
import 'package:facebook_app/my_widgets/post/comment_item.dart';
import 'package:flutter/material.dart';

class ListCommentWidget extends StatelessWidget {
  final List<CommentModel> comments;

  const ListCommentWidget({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return comments.isEmpty
        ? Container()
        : SingleChildScrollView(
            child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: CommentItem(
                      comment: comments[index],
                    ),
                  );
                },
                itemCount: comments.length));
  }
}
