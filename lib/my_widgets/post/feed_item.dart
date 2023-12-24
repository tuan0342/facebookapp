import 'package:auto_size_text/auto_size_text.dart';
import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/my_widgets/post/list_image_layout.dart';
import 'package:facebook_app/my_widgets/post/video/video_screen.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/feed_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../my_filled_button.dart';

// ignore: must_be_immutable
class FeedItem extends StatefulWidget {
  final Post postData;
  final VoidCallback refresh;
  final Function onReportItem;
  const FeedItem({super.key, required this.postData, required this.refresh, required this.onReportItem});

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  bool isLoading = false;

  void reportPost(BuildContext context, String subject, String details) async {
    final success = await FeedService(context: context)
        .reportPost(context: context, id: widget.postData.id, subject: subject, details: details);
    if (success) {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context,
          msg: "Đã báo cáo video bài viết vi phạm");
      widget.onReportItem(widget.postData.id);
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

  void onClickKudosBtn(FeedService feedService) async {
    setState(() {
      isLoading = true;
    });
    if (widget.postData.isFelt == -1) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: widget.postData.author.id,
          postId: widget.postData.id,
          feelType: 1);
      if (isSuccess) {
        setState(() {
          widget.postData.isFelt = 1;
          widget.postData.feel += 1;
        });
      }
    } else if (widget.postData.isFelt == 0) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: widget.postData.author.id,
          postId: widget.postData.id,
          feelType: 1);
      if (isSuccess) {
        setState(() {
          widget.postData.isFelt = 1;
        });
      }
    } else {
      final isSuccess = await feedService.deleteFeelPost(
          context: context, postId: widget.postData.id);

      if (isSuccess) {
        setState(() {
          widget.postData.isFelt = -1;
          widget.postData.feel -= 1;
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void onClickDisapointedBtn(FeedService feedService) async {
    setState(() {
      isLoading = true;
    });
    if (widget.postData.isFelt == -1) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: widget.postData.author.id,
          postId: widget.postData.id,
          feelType: 0);
      if (isSuccess) {
        setState(() {
          widget.postData.isFelt = 0;
          widget.postData.feel += 1;
        });
      }
    } else if (widget.postData.isFelt == 1) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: widget.postData.author.id,
          postId: widget.postData.id,
          feelType: 0);
      if (isSuccess) {
        setState(() {
          widget.postData.isFelt = 0;
        });
      }
    } else {
      final isSuccess = await feedService.deleteFeelPost(
          context: context, postId: widget.postData.id);

      if (isSuccess) {
        setState(() {
          widget.postData.isFelt = -1;
          widget.postData.feel -= 1;
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void onClickMarkdBtn(FeedService feedService) async {
    setState(() {
      isLoading = true;
    });
    context.push("/authenticated/postDetail/${widget.postData.id}");
    setState(() {
      isLoading = false;
    });
  }

  void deletePost(BuildContext context, int id) async {
    await FeedService(context: context)
        .deletePost(context: context, postId: id);
    widget.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);
    final FeedService feedService = FeedService(context: context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // header
        postHeader(appService),
        const SizedBox(
          height: 16,
        ),
        // content
        postContent(),
        const SizedBox(
          height: 16,
        ),
        postFooter(feedService),
      ],
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
    switch (widget.postData.isFelt) {
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

  Widget kudosButton(FeedService feedService) {
    return Expanded(
      child: InkWell(
        onTap: isLoading
            ? null
            : () {
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
                      widget.postData.isFelt == 1 ? Colors.blue : Colors.grey),
              const SizedBox(
                width: 4,
              ),
              Text(
                "Kudos",
                style: TextStyle(
                    color: widget.postData.isFelt == 1
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
        onTap: isLoading
            ? null
            : () {
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
                      widget.postData.isFelt == 0 ? Colors.red : Colors.grey),
              const SizedBox(
                width: 4,
              ),
              Text(
                "Diss",
                style: TextStyle(
                    color:
                        widget.postData.isFelt == 0 ? Colors.red : Colors.grey),
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
          onTap: isLoading
              ? null
              : () {
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

  Widget postHeader(AppService appService) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            GestureDetector(
              onTap: () {
                context.push(
                    "/authenticated/personalPage/${widget.postData.author.id}");
              },
              child: MyImage(
                  imageUrl: widget.postData.author.avatar,
                  height: 44,
                  width: 44),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 130,
                  child: RichText(
                    text: TextSpan(
                      text: widget.postData.author.name,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: widget.postData.state.isNotEmpty
                              ? " đang cảm thấy ${widget.postData.state}"
                              : "",
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    softWrap: true,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  getDifferenceTime(
                      DateTime.now(), DateTime.parse(widget.postData.created)),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.more_horiz,
            size: 24,
            color: Colors.grey[600],
          ),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // TextButton(
                        //     onPressed: () {},
                        //     child: const Row(
                        //       children: [
                        //         Icon(
                        //           Icons.add_alert,
                        //           color: Colors.black,
                        //         ),
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         Text(
                        //           "Tắt thông báo về bài viết này",
                        //           style: TextStyle(
                        //               color: Colors.black,
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.normal),
                        //         )
                        //       ],
                        //     )),
                        // TextButton(
                        //     onPressed: () {},
                        //     child: const Row(
                        //       children: [
                        //         Icon(Icons.save, color: Colors.black),
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         Text(
                        //           "Lưu bài viết",
                        //           style: TextStyle(
                        //               color: Colors.black,
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.normal),
                        //         )
                        //       ],
                        //     )),
                        TextButton(
                            onPressed: () {
                              _showReportMenu(context);
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.warning_amber_rounded, color: Colors.black),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Báo cáo bài viết",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            )),
                        (widget.postData.author.name == appService.username)
                            ? TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  context
                                      .push("/authenticated/editPost",
                                          extra: widget.postData)
                                      .then((value) => widget.refresh());
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Chỉnh sửa bài viết",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ))
                            : Container(),
                        (widget.postData.author.name == appService.username)
                            ? TextButton(
                                onPressed: () {
                                  deletePost(context, widget.postData.id);
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.delete_rounded,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Xóa",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ))
                            : Container(),

                        // widget.postData.author.name == appService.username ?
                      ],
                    ),
                  );
                });
          },
        ),
      ],
    );
  }

  Widget postContent() {
    return GestureDetector(
      onLongPress: () {
        showPopover(
            direction: PopoverDirection.top,
            context: context,
            bodyBuilder: (context) => TextButton(
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: widget.postData.described));
                  Navigator.pop(context);
                },
                child: const Text("Copy")));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadMoreText(
              widget.postData.described,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  // height: 1.2,
                  letterSpacing: .3),
              trimExpandedText: "Thu gọn",
              trimCollapsedText: "Đọc thêm",
            ),
            const SizedBox(
              height: 8,
            ),
            widget.postData.image.isNotEmpty
                ? ListImageLayout(
                    fullHeight: 300,
                    images: widget.postData.image,
                    postId: widget.postData.id,
                  )
                : widget.postData.video.url.isNotEmpty
                    ? VideoPlayerScreen(
                        url: widget.postData.video.url,
                      )
                    : Container()
          ],
        ),
      ),
    );
  }

  Widget postFooter(FeedService feedService) {
    return Column(
      children: [
        if (widget.postData.feel > 0 || widget.postData.markComment > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 5),
                child: widget.postData.feel > 0
                    ? Row(
                        children: [
                          allReactIcon(widget.postData.feel),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${widget.postData.feel}",
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
                padding: const EdgeInsets.only(right: 5),
                child: widget.postData.markComment > 0
                    ? GestureDetector(
                        onTap: () {
                          context.push(
                              "/authenticated/postDetail/${widget.postData.id}");
                        },
                        child: Row(
                          children: [
                            Text(
                              "${widget.postData.markComment} marks & comments",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              )
            ],
          ),
        const SizedBox(
          height: 8,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            height: 1,
            thickness: 0.2,
            color: Colors.black54,
          ),
        ),
        postAction(feedService),
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
}
