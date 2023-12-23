import 'package:facebook_app/models/mark_comment_model.dart';
import 'package:facebook_app/my_widgets/post/mark_item.dart';
import 'package:facebook_app/services/feed_service.dart';
import 'package:flutter/material.dart';

class MarkCommentComponent extends StatefulWidget {
  final int postId;
  final int postOwnerId;
  const MarkCommentComponent(
      {super.key, required this.postId, required this.postOwnerId});

  @override
  State<MarkCommentComponent> createState() => _MarkCommentComponentState();
}

class _MarkCommentComponentState extends State<MarkCommentComponent> {
  final _formKey = GlobalKey<FormState>();
  final markCommentController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  int? markType = 0;

  List<MarkModel> marks = [];

  bool isEnd = false;
  bool isLoading = false;
  bool isSubmitting = false;
  int index = 0;
  static const int count = 5;

  void getMarkComment() async {
    setState(() {
      isLoading = true;
    });

    final fetchResult = await FeedService(context: context)
        .getMarkComment(postId: widget.postId, index: index, count: count);
    if (fetchResult.isEmpty) {
      setState(() {
        isEnd = true;
      });
    } else {
      setState(() {
        marks.addAll(fetchResult);
        index = index + count;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void handleMarkSubmit() async {
    setState(() {
      isSubmitting = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        final marksReturn = await FeedService(context: context).setMarkComment(
            count: count,
            postId: widget.postId,
            receiverId: widget.postOwnerId,
            content: markCommentController.text,
            markId: 0,
            markType: markType!);
        if (marksReturn.isNotEmpty) {
          setState(() {
            marks = marksReturn;
            index = 0;
          });
          markCommentController.text = "";
        }
      }
    } catch (err) {
      debugPrint("error when comment: $err");
    }
    setState(() {
      isSubmitting = false;
    });
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter == 0) {
      getMarkComment();
    }
  }

  @override
  void initState() {
    super.initState();
    index = 0;
    scrollController.addListener(_scrollListener);
    getMarkComment();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        markCommentInput(),
        listMarksWidget(),
      ],
    );
  }

  Widget listMarksWidget() {
    return marks.isEmpty
        ? const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child:
                Center(child: Text("Hãy là người mark đầu tiên cho bài viết")),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                  child: ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: MarkItem(
                            postID: widget.postId,
                            postOwnerId: widget.postOwnerId,
                            mark: marks[index],
                          ),
                        );
                      },
                      itemCount: marks.length)),
              if (isLoading) const CircularProgressIndicator()
            ],
          );
  }

  Widget markCommentInput() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Radio<int>(
                  value: 0,
                  groupValue: markType,
                  onChanged: (int? value) {
                    setState(() {
                      markType = value!;
                    });
                  },
                ),
                Text(
                  'Fake',
                  style: TextStyle(
                      color: markType == 0 ? Colors.blue : Colors.black),
                ),
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: markType,
                  onChanged: (int? value) {
                    setState(() {
                      markType = value!;
                    });
                  },
                ),
                Text('Trust',
                    style: TextStyle(
                        color: markType == 1 ? Colors.blue : Colors.black)),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: TextFormField(
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
                    hintText: "Mark content",
                    suffixIcon: IconButton(
                        onPressed: isSubmitting
                            ? null
                            : () {
                                handleMarkSubmit();
                              },
                        icon: Icon(Icons.send,
                            color: isSubmitting ? Colors.grey : Colors.blue)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    filled: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
