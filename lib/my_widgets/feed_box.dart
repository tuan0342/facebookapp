import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FeedBox extends StatelessWidget {
  Post post;
  final Function() ontap;
  FeedBox({required this.post, required this.ontap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  MyImage(imageUrl: post.author.avatar, height: 50, width: 50),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        post.author.name,
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
                            DateTime.now(), DateTime.parse(post.created)),
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  size: 30,
                  color: Colors.grey[600],
                ),
                onPressed: () {},
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              post.described,
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
          post.image.isNotEmpty
              ? MyImage(imageUrl: post.image[0].url, height: 150, width: 150)
              : Container(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 5),
                child: Row(
                  children: <Widget>[
                    Row(
                      children: [
                        makeKudos(),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${post.feel}",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  "${post.markComment} Marks",
                  style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              makeKudosButton(isActive: true),
              makeMarkButton(),
              makeDisappointedButton(isActive: true),
            ],
          )
        ],
      ),
    );
  }

  Widget makeKudos() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)),
      child: const Center(
        child: Icon(Icons.check, size: 12, color: Colors.white),
      ),
    );
  }

  Widget makeDisappointed() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)),
      child: const Center(
        child: Icon(Icons.dangerous_outlined, size: 20, color: Colors.white),
      ),
    );
  }

  Widget makeKudosButton({isActive}) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(left: 20, top: 5),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            // backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )),
        onPressed: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check,
              color: isActive ? Colors.blue : Colors.grey,
              size: 18,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Kudos",
              style: TextStyle(color: isActive ? Colors.blue : Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  Widget makeDisappointedButton({isActive}) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 20, top: 5),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            // backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )),
        onPressed: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.dangerous_outlined,
              color: isActive ? Colors.red : Colors.grey,
              size: 18,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Diss",
              style: TextStyle(color: isActive ? Colors.red : Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  Widget makeMarkButton() {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(top: 5),
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
}
