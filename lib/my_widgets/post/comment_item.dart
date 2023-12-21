import 'package:facebook_app/models/mark_comment_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;

  const CommentItem({super.key, required this.comment});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyImage(
          imageUrl: comment.poster.avatar,
          width: 30,
          height: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 130,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.poster.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ReadMoreText(
                    comment.content,
                    trimLength: 150,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[800],
                        height: 1.5,
                        letterSpacing: .7),
                    trimExpandedText: "Thu gọn",
                    trimCollapsedText: "Đọc thêm",
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(getDifferenceTime(
                    DateTime.now(), DateTime.parse(comment.created))),
              ],
            )
          ],
        )
      ],
    );
  }
}
