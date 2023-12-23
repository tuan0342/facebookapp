
import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/my_widgets/post/list_image_layout.dart';
import 'package:facebook_app/my_widgets/post/video/video_screen.dart';
import 'package:facebook_app/services/feed_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../../services/app_service.dart';

// ignore: must_be_immutable
class FeedItem extends StatefulWidget {
  final Post postData;
  const FeedItem({super.key, required this.postData});

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {

  bool isLoading = false;
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
    await FeedService(context: context).deletePost(context: context, postId: id);

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
          height: 20,
        ),
        // content
        postContent(),
        const SizedBox(
          height: 20,
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
    return SizedBox(
      width: 100,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            // backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )),
        onPressed: isLoading
            ? null
            : () {
                onClickKudosBtn(feedService);
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            kudosIcon(
                bgColor: Colors.white,
                iconColor:
                    widget.postData.isFelt == 1 ? Colors.blue : Colors.grey),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Kudos",
              style: TextStyle(
                  color:
                      widget.postData.isFelt == 1 ? Colors.blue : Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  Widget disappointedButton(FeedService feedService) {
    return SizedBox(
      width: 100,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            // backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )),
        onPressed: isLoading
            ? null
            : () {
                onClickDisapointedBtn(feedService);
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            disappointedIcon(
                bgColor: Colors.white,
                iconColor:
                    widget.postData.isFelt == 0 ? Colors.red : Colors.grey),
            const SizedBox(
              width: 5,
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
    );
  }

  Widget markButton(FeedService feedService) {
    return SizedBox(
      width: 100,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )),
        onPressed: isLoading
            ? null
            : () {
                onClickMarkdBtn(feedService);
              },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.comment, color: Colors.grey, size: 18),
            SizedBox(
              width: 5,
            ),
            Text(
              "Mark",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
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
                  height: 50,
                  width: 50),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.postData.author.name + " cảm thấy ${widget.postData.state}",
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  getDifferenceTime(
                      DateTime.now(), DateTime.parse(widget.postData.created)),
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.more_horiz,
            size: 25,
            color: Colors.grey[600],
          ),
          onPressed: () {
            debugPrint("${widget.postData.toJson()}");
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: (){},
                            child: const Row(
                              children: [
                                Icon(Icons.add_alert, color: Colors.black,),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    "Tắt thông báo về bài viết này",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal
                                  ),
                                )
                              ],
                            )
                        ),
                        TextButton(
                            onPressed: (){},
                            child: const Row(
                              children: [
                                Icon(Icons.save, color: Colors.black),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    "Lưu bài viết",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal
                                  ),

                                )
                              ],
                            )
                        ),
                        (widget.postData.author.name == appService.username) ?
                        TextButton(
                            onPressed: (){
                              Navigator.pop;
                              context.go("/authenticated/editPost", extra: widget.postData);
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.edit,color: Colors.black,),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    "Chỉnh sửa bài viết",
                                    style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal
                                ),
                                )
                              ],
                            )
                        ) : Container(),
                        (widget.postData.author.name == appService.username) ?
                        TextButton(
                            onPressed: (){
                              deletePost(context, widget.postData.id);
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.delete_rounded, color: Colors.black,),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    "Xóa",
                                    style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal
                                    ),

                                )
                              ],
                            )
                        ) : Container(),




                        // widget.postData.author.name == appService.username ?


                      ],
                    ),

                  );
            }
            );
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
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                  height: 1.5,
                  letterSpacing: .7),
              trimExpandedText: "Thu gọn",
              trimCollapsedText: "Đọc thêm",
            ),
            const SizedBox(
              height: 15,
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
                            width: 5,
                          ),
                          Text(
                            "${widget.postData.feel}",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[800]),
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
                              "${widget.postData.markComment} Marks & Comments",
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
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            kudosButton(feedService),
            markButton(feedService),
            disappointedButton(feedService),
          ],
        ),
      ],
    );
  }
}
