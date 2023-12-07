import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FeedItem extends StatelessWidget {
  final Post postData;
  const FeedItem({required this.postData});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        postHeader(),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            postData.described,
            style: TextStyle(
                fontSize: 15,
                color: Colors.grey[800],
                height: 1.5,
                letterSpacing: .7),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        postData.image.isNotEmpty
            ? MyImage(imageUrl: postData.image[0].url, height: 150, width: 150)
            : Container(),
        const SizedBox(
          height: 20,
        ),
        postFooter(),
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
    switch (postData.isFelt) {
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

  Widget kudosButton() {
    return Container(
      width: 100,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            // backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            kudosIcon(
                bgColor: Colors.white,
                iconColor: postData.isFelt == 1 ? Colors.blue : Colors.grey),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Kudos",
              style: TextStyle(
                  color: postData.isFelt == 1 ? Colors.blue : Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  Widget disappointedButton() {
    return SizedBox(
      width: 100,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            // backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )),
        onPressed: () {
          debugPrint("click");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            disappointedIcon(
                bgColor: Colors.white,
                iconColor: postData.isFelt == 0 ? Colors.red : Colors.grey),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Diss",
              style: TextStyle(
                  color: postData.isFelt == 0 ? Colors.red : Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  Widget markButton() {
    return SizedBox(
      width: 100,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )),
        onPressed: () {},
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
            MyImage(imageUrl: postData.author.avatar, height: 50, width: 50),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  postData.author.name,
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
                      DateTime.now(), DateTime.parse(postData.created)),
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
    return Container();
  }

  Widget postFooter() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 3),
      child: Column(
        children: [
          if (postData.feel >0 || postData.markComment > 0) Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 5),
                child: postData.feel > 0 ? Row(
                  children: [
                    allReactIcon(postData.feel),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${postData.feel}",
                      style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                    ),
                  ],
                ) : Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child:postData.markComment > 0 ? Row(
                  children: [
                    Text(
                      "${postData.markComment} Marks",
                      style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                    ),
                  ],
                ): Container(),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              kudosButton(),
              markButton(),
              disappointedButton(),
            ],
          )
        ],
      ),
    );
  }
}
