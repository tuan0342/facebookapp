import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/my_widgets/post/list_image_layout.dart';
import 'package:facebook_app/services/feed_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FeedItemDetail extends StatefulWidget {
  final String postId;
  const FeedItemDetail({super.key, required this.postId});

  @override
  State<FeedItemDetail> createState() => _FeedItemDetailState();
}

class _FeedItemDetailState extends State<FeedItemDetail> {
  PostDetailModel? postDetail;
  bool isLoading = false;

  void getPostDetail() async {
    setState(() {
      isLoading = true;
    });
    final post = await FeedService(context: context)
        .getPost(postId: int.parse(widget.postId));

    if (post != null) {
      setState(() {
        postDetail = post;
      });
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "Có lỗi xảy ra khi lấy thông tin bài viết");
    }
    setState(() {
      isLoading = false;
    });
  }

  void onClickKudosBtn(FeedService feedService) async {
    setState(() {
      isLoading = true;
    });
    if (postDetail!.isFelt == -1) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: postDetail!.author.id,
          postId: postDetail!.id,
          feelType: 1);
      if (isSuccess) {
        setState(() {
          postDetail!.isFelt = 1;
          postDetail!.kudos += 1;
        });
      }
    } else if (postDetail!.isFelt == 0) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: postDetail!.author.id,
          postId: postDetail!.id,
          feelType: 1);
      if (isSuccess) {
        setState(() {
          postDetail!.isFelt = 1;
          postDetail!.kudos += 1;
          postDetail!.disapointed -= 1;
        });
      }
    } else {
      final isSuccess = await feedService.deleteFeelPost(
          context: context, postId: postDetail!.id);

      if (isSuccess) {
        setState(() {
          postDetail!.isFelt = -1;
          postDetail!.kudos -= 1;
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
    if (postDetail!.isFelt == -1) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: postDetail!.author.id,
          postId: postDetail!.id,
          feelType: 0);
      if (isSuccess) {
        setState(() {
          postDetail!.isFelt = 0;
          postDetail!.disapointed += 1;
        });
      }
    } else if (postDetail!.isFelt == 1) {
      final isSuccess = await feedService.feelPost(
          context: context,
          postOwnerId: postDetail!.author.id,
          postId: postDetail!.id,
          feelType: 0);
      if (isSuccess) {
        setState(() {
          postDetail!.isFelt = 0;
          postDetail!.disapointed += 1;
          postDetail!.kudos -= 1;
        });
      }
    } else {
      final isSuccess = await feedService.deleteFeelPost(
          context: context, postId: postDetail!.id);

      if (isSuccess) {
        setState(() {
          postDetail!.isFelt = -1;
          postDetail!.disapointed -= 1;
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
    // if (postDetail.isFelt == -1) {
    // } else if (postDetail.isFelt == 1) {
    // } else {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostDetail();
  }

  @override
  Widget build(BuildContext context) {
    final FeedService feedService = FeedService(context: context);
    return postDetail == null
        ? Scaffold(
            appBar: AppBar(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                postDetail!.author.name,
                style: const TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
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
                  ),
                ),
              ),
            ),
          );
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
                iconColor: postDetail!.isFelt == 1 ? Colors.blue : Colors.grey),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Kudos",
              style: TextStyle(
                  color: postDetail!.isFelt == 1 ? Colors.blue : Colors.grey),
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
                iconColor: postDetail!.isFelt == 0 ? Colors.red : Colors.grey),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Diss",
              style: TextStyle(
                  color: postDetail!.isFelt == 0 ? Colors.red : Colors.grey),
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

  Widget postHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            MyImage(imageUrl: postDetail!.author.avatar, height: 50, width: 50),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  postDetail!.author.name,
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
                      DateTime.now(), DateTime.parse(postDetail!.created)),
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
          Text(
            postDetail!.described,
            style: TextStyle(
                fontSize: 15,
                color: Colors.grey[800],
                height: 1.5,
                letterSpacing: .7),
          ),
          const SizedBox(
            height: 15,
          ),
          postDetail?.image.isNotEmpty == true
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: ListImageLayout(
                            images: [postDetail!.image[index]],
                            postId: postDetail!.id),
                      )),
                  itemCount: postDetail!.image.length,
                )
              : Container()
        ],
      ),
    );
  }

  Widget postFooter(FeedService feedService) {
    return Column(
      children: [
        if (postDetail!.kudos > 0 ||
            postDetail!.disapointed > 0 ||
            postDetail!.fake > 0 ||
            postDetail!.trust > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 5),
                child: postDetail!.kudos > 0 || postDetail!.disapointed > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (postDetail!.kudos > 0)
                            SizedBox(
                              child: Row(children: [
                                kudosIcon(),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "${postDetail!.kudos}",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey[800]),
                                ),
                                const SizedBox(
                                  width: 6,
                                )
                              ]),
                            ),
                          if (postDetail!.kudos > 0)
                            SizedBox(
                              child: Row(children: [
                                disappointedIcon(),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "${postDetail!.disapointed}",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey[800]),
                                ),
                              ]),
                            )
                        ],
                      )
                    : Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: postDetail!.fake >= 0 || postDetail!.trust >= 0
                    ? Row(
                        children: [
                          if (postDetail!.fake >= 0)
                            Text(
                              "${postDetail!.fake} Fake",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[800]),
                            ),
                          const SizedBox(
                            width: 6,
                          ),
                          if (postDetail!.trust >= 0)
                            Text(
                              "${postDetail!.trust} Trust",
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
