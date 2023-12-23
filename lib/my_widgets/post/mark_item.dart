import 'package:facebook_app/models/mark_comment_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/my_widgets/post/list_comment.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/feed_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

// ignore: must_be_immutable
class MarkItem extends StatefulWidget {
  final int postID;
  final int postOwnerId;
  MarkModel mark;

  MarkItem(
      {super.key,
      required this.mark,
      required this.postID,
      required this.postOwnerId});

  @override
  State<MarkItem> createState() => _MarkItemState();
}

class _MarkItemState extends State<MarkItem> {
  final _formKey = GlobalKey<FormState>();

  final markCommentController = TextEditingController();
  bool isCommentSelected = false;
  bool isSubmitting = false;

  void handleCommentSubmit(AppService appService) async {
    setState(() {
      isSubmitting = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        final marks = await FeedService(context: context).setMarkComment(
            receiverId: widget.mark.poster.id,
            postId: widget.postID,
            content: markCommentController.text,
            markId: widget.mark.id,
            markType: -1);
        if (marks.isNotEmpty) {
          setState(() {
            widget.mark.comments.insert(
                0,
                CommentModel(
                    content: markCommentController.text,
                    created: DateTime.now().toString(),
                    poster: PosterModel(
                        id: int.parse(appService.uidLoggedIn),
                        name: appService.username,
                        avatar: appService.avatar)));
            isCommentSelected = false;
          });
          markCommentController.text = "";
        }
      }
    } catch (err) {
      debugPrint("error when mark: $err");
    }
    setState(() {
      isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppService appService = Provider.of<AppService>(context, listen: false);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyImage(
          imageUrl: widget.mark.poster.avatar,
          width: 40,
          height: 40,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 80,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.mark.poster.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ReadMoreText(
                    widget.mark.markContent,
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
              children: [
                Text(getDifferenceTime(
                    DateTime.now(), DateTime.parse(widget.mark.created))),
                SizedBox(
                  height: 30,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0)),
                      onPressed: () {
                        setState(() {
                          isCommentSelected = !isCommentSelected;
                        });
                      },
                      child: const Text("Phản hồi")),
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              child: Column(children: [
                if (isCommentSelected) commentInput(appService),
                widget.mark.comments.isNotEmpty
                    ? ListCommentWidget(
                        comments: widget.mark.comments,
                      )
                    : Container()
              ]),
            )
          ],
        )
      ],
    );
  }

  Widget commentInput(AppService appService) {
    return Form(
      key: _formKey,
      child: TextFormField(
        autofocus: true,
        onFieldSubmitted: (value) {
          if (value.isEmpty) {
            setState(() {
              isCommentSelected = false;
            });
          }
        },
        controller: markCommentController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "chưa điền nội dung";
          }
          return null;
        },
        cursorColor: Colors.black,
        cursorWidth: 1,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          hintText: "Comment",
          suffixIcon: IconButton(
              onPressed: isSubmitting
                  ? null
                  : () {
                      handleCommentSubmit(appService);
                    },
              icon: Icon(Icons.send,
                  color: isSubmitting ? Colors.grey : Colors.blue)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          filled: true,
        ),
      ),
    );
  }
}
