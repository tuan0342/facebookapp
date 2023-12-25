import 'package:facebook_app/my_widgets/my_editText.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/pages/authenticated/video/my_widgets/video_player.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/video_post_model.dart';
import '../../../../services/feed_service.dart';
import '../../../../services/friend_service.dart';

class VideoPostItem extends StatefulWidget {
  final VideoPost videoPost;
  final bool isInView;
  final int index;
  final Function onBlock;
  final Function onReport;

  const VideoPostItem({
    super.key,
    required this.videoPost,
    required this.isInView,
    required this.index,
    required this.onBlock,
    required this.onReport,
  });

  @override
  _VideoPostItemState createState() => _VideoPostItemState();
}

class _VideoPostItemState extends State<VideoPostItem> {
  bool isBlocked = false;

  void onClickKudosBtn(FeedService feedService) async {
    if (widget.videoPost.isFelt == -1) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: widget.videoPost.author.id,
          postId: widget.videoPost.id,
          feelType: 1);
      if (isSuccess) {
        setState(() {
          widget.videoPost.isFelt = 1;
          widget.videoPost.feel += 1;
        });
      }
    } else if (widget.videoPost.isFelt == 0) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: widget.videoPost.author.id,
          postId: widget.videoPost.id,
          feelType: 1);
      if (isSuccess) {
        setState(() {
          widget.videoPost.isFelt = 1;
        });
      }
    } else {
      final isSuccess = await feedService.deleteFeelPost(
          context: context, postId: widget.videoPost.id);

      if (isSuccess) {
        setState(() {
          widget.videoPost.isFelt = -1;
          widget.videoPost.feel -= 1;
        });
      }
    }
  }

  void onClickDisapointedBtn(FeedService feedService) async {
    if (widget.videoPost.isFelt == -1) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: widget.videoPost.author.id,
          postId: widget.videoPost.id,
          feelType: 0);
      if (isSuccess) {
        setState(() {
          widget.videoPost.isFelt = 0;
          widget.videoPost.feel += 1;
        });
      }
    } else if (widget.videoPost.isFelt == 1) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: widget.videoPost.author.id,
          postId: widget.videoPost.id,
          feelType: 0);
      if (isSuccess) {
        setState(() {
          widget.videoPost.isFelt = 0;
        });
      }
    } else {
      final isSuccess = await feedService.deleteFeelPost(
          context: context, postId: widget.videoPost.id);

      if (isSuccess) {
        setState(() {
          widget.videoPost.isFelt = -1;
          widget.videoPost.feel -= 1;
        });
      }
    }
  }

  void onClickMarkdBtn(FeedService feedService) async {
    context.push("/authenticated/postDetail/${widget.videoPost.id}");
  }

  void onAddFriend(BuildContext context) async {
    final isSendRequested = await FriendService(context: context)
        .setRequestFriend(int.parse(widget.videoPost.author.id.toString()));

    if (isSendRequested) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: "Đã gửi lời mời kết bạn");
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  void blockFriend(BuildContext context) async {
    final success = await FriendService(context: context)
        .setBlocksFriend(widget.videoPost.author.id.toString());
    if (success) {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context,
          msg: "Đã chặn tài khoản ${widget.videoPost.author.name}");
      setState(() {
        isBlocked = true;
      });
      widget.onBlock(widget.videoPost.author.id);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  void reportPost(BuildContext context, String subject, String details) async {
    final success = await FeedService(context: context)
      .reportPost(context: context, id: widget.videoPost.id, subject: subject, details: details);
    if (success) {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context,
          msg: "Đã báo cáo video bài viết vi phạm");
      widget.onReport(widget.videoPost.id);
      Navigator.of(context).pop();
    }
  }

  void _showReportMenu(BuildContext context) {
    final TextEditingController _textFieldSubjectController = TextEditingController();
    final TextEditingController _textFieldDetailsController = TextEditingController();
    Navigator.of(context).pop();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              height: 280 + MediaQuery.of(context).viewInsets.bottom,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
                right: 24,
                left: 24,
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: _textFieldSubjectController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Subject',
                    ),
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: _textFieldDetailsController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Details',
                    ),
                  ),
                  SizedBox(height: 32,),
                  MyFilledButton(
                    title: "Báo cáo",
                    isDisabled: false,
                    cbFunction: () {
                      String subject = _textFieldSubjectController.text;
                      String details = _textFieldDetailsController.text;
                      reportPost(context, subject, details);
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void _showOptionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 180,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  onAddFriend(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(Icons.person_add_outlined),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        "Thêm bạn",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  blockFriend(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(Icons.block_rounded),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        "Chặn người dùng",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                    _showReportMenu(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: Icon(Icons.warning_amber_rounded),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Text(
                          "Báo cáo vi phạm",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final FeedService feedService = FeedService(context: context);

    String formattedCreatedAt = getDifferenceTime(
        DateTime.now(), DateTime.parse(widget.videoPost.created));
    return isBlocked
        ? Container()
        : Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 6,
                  width: double.infinity,
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              context.push(
                                  "/authenticated/personalPage/${widget.videoPost.author.id}");
                            },
                            child: MyImage(
                                imageUrl: widget.videoPost.author.avatar,
                                width: 44,
                                height: 44),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.push(
                                      "/authenticated/personalPage/${widget.videoPost.author.id}");
                                },
                                child: Text(
                                  widget.videoPost.author.name,
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                formattedCreatedAt,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 12),
                              ),
                            ],
                          )),
                          InkWell(
                            onTap: () {
                              _showOptionModal(context);
                            },
                            child: Icon(Icons.more_horiz_rounded,
                                color: Colors.grey[600]),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.videoPost.described),
                      )
                    ],
                  ),
                ),
                AspectRatio(
                  aspectRatio: 4 / 3, // You may adjust this ratio as needed
                  child: Container(
                    color: Colors.black, // Placeholder color for the video
                    child: Center(
                        child: MyVideoPlayer(
                      videoUrl: widget.videoPost.video.url,
                      isInView: widget.isInView,
                      videoPost: widget.videoPost,
                      index: widget.index,
                    )),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.all(12.0),
                //   child: Text(
                //     "${widget.videoPost.markComment} comment marks",
                //     style: TextStyle(
                //       fontSize: 12.0,
                //       fontWeight: FontWeight.w300,
                //     ),
                //   ),
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Expanded(
                //       child: Center(child: Text("Thích")),
                //     ),
                //     Expanded(
                //       child: Center(child: Text("Bình luận")),
                //     ),
                //     Expanded(
                //       child: Center(child: Text("Chia sẻ")),
                //     )
                //   ],
                // ),
                const SizedBox(
                  height: 12,
                ),
                postFooter(feedService),
                const SizedBox(
                  height: 6,
                ),
                postAction(feedService),
              ],
            ),
          );
  }

  Widget postFooter(FeedService feedService) {
    return Column(
      children: [
        if (widget.videoPost.feel > 0 || widget.videoPost.markComment > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: widget.videoPost.feel > 0
                    ? Row(
                        children: [
                          allReactIcon(widget.videoPost.feel),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${widget.videoPost.feel}",
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    : Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: widget.videoPost.markComment > 0
                    ? Row(
                        children: [
                          Text(
                            "${widget.videoPost.markComment} marks & comments",
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    : Container(),
              )
            ],
          ),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          height: 1,
          thickness: 0.2,
          color: Colors.black54,
        ),
      ],
    );
  }

  Widget postAction(FeedService feedService) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        kudosButton(feedService),
        markButton(feedService),
        disappointedButton(feedService),
      ],
    );
  }

  Widget kudosButton(FeedService feedService) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onClickKudosBtn(feedService);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              kudosIcon(
                  bgColor: Colors.white,
                  iconColor:
                      widget.videoPost.isFelt == 1 ? Colors.blue : Colors.grey),
              const SizedBox(
                width: 4,
              ),
              Text(
                "Kudos",
                style: TextStyle(
                    color: widget.videoPost.isFelt == 1
                        ? Colors.blue
                        : Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget disappointedButton(FeedService feedService) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onClickDisapointedBtn(feedService);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              disappointedIcon(
                  bgColor: Colors.white,
                  iconColor:
                      widget.videoPost.isFelt == 0 ? Colors.red : Colors.grey),
              const SizedBox(
                width: 4,
              ),
              Text(
                "Diss",
                style: TextStyle(
                    color: widget.videoPost.isFelt == 0
                        ? Colors.red
                        : Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget markButton(FeedService feedService) {
    return Expanded(
      child: InkWell(
          onTap: () {
            onClickMarkdBtn(feedService);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.comment, color: Colors.grey, size: 18),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Mark",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          )),
    );
  }

  Widget allReactIcon(int numOfReact) {
    final multiFeelIcon = Stack(
      children: [
        Positioned(left: 13, child: disappointedIcon()),
        Positioned(
            child: Row(
          children: [
            kudosIcon(),
            const SizedBox(
              width: 13,
            )
          ],
        )),
      ],
    );
    switch (widget.videoPost.isFelt) {
      // user haven't yet react
      case -1:
        if (numOfReact <= 0) {
          return Container();
        } else if (numOfReact == 1) {
          return kudosIcon();
        } else {
          return multiFeelIcon;
        }
      // user disapointed
      case 0:
        if (numOfReact <= 0) {
          return Container();
        } else if (numOfReact == 1) {
          return disappointedIcon();
        } else {
          return multiFeelIcon;
        }
      // user kudos
      case 1:
        if (numOfReact <= 0) {
          return Container();
        } else if (numOfReact == 1) {
          return kudosIcon();
        } else {
          return multiFeelIcon;
        }
      default:
        return Container();
    }
  }

  Widget kudosIcon(
      {double bgSize = 20,
      Color bgColor = Colors.blue,
      double iconSize = 15,
      Color iconColor = Colors.white}) {
    return Container(
      width: bgSize,
      height: bgSize,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(Icons.check, size: iconSize, color: iconColor),
      ),
    );
  }

  Widget disappointedIcon(
      {double bgSize = 20,
      Color bgColor = Colors.red,
      double iconSize = 15,
      Color iconColor = Colors.white}) {
    return Container(
      width: bgSize,
      height: bgSize,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(Icons.close, size: iconSize, color: iconColor),
      ),
    );
  }
}
