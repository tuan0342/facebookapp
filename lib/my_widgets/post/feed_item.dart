import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/my_widgets/post/list_image_layout.dart';
import 'package:facebook_app/services/feed_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

// ignore: must_be_immutable
class FeedItem extends StatefulWidget {
  final Post postData;
  const FeedItem({required this.postData});

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  void onClickKudosBtn(FeedService feedService) async {
    if (widget.postData.isFelt == -1) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: 80,
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
          postOwnerId: 80,
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
  }

  void onClickDisapointedBtn(FeedService feedService) async {
    if (widget.postData.isFelt == -1) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: 80,
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
          postOwnerId: 80,
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
  }

  void onClickMarkdBtn(FeedService feedService) async {
    if (widget.postData.isFelt == -1) {
    } else if (widget.postData.isFelt == 1) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final FeedService feedService = FeedService(context: context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // header
        postHeader(),
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
    return Container(
      width: 100,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            // backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )),
        onPressed: () {
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
        onPressed: () {
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
        onPressed: () {
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

  Widget postHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            MyImage(
                imageUrl: widget.postData.author.avatar, height: 50, width: 50),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.postData.author.name,
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
          onPressed: () {},
        ),
      ],
    );
  }

  Widget postContent() {
    return Padding(
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
          const SizedBox(height: 15,),
          widget.postData.image.isNotEmpty
              ? ListImageLayout(images: widget.postData.image)
              : Container()
        ],
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
                    ? Row(
                        children: [
                          Text(
                            "${widget.postData.markComment} Marks",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[800]),
                          ),
                        ],
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
        )
      ],
    );
  }
}