import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/my_widgets/feed_box.dart';
import 'package:facebook_app/pages/createNewFeed/NewFeed.dart';
import 'package:facebook_app/services/feed_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.email});
  final String email;

  @override
  State<HomePage> createState() {
    return mainHomePageState();
  }
}

class mainHomePageState extends State<HomePage> {
  List<Post>? feeds;

  void clickDissappointedButton(int index) {
    if (FeedService().updateFeed(index)) {
      // setState(() {
      //   feeds![index].disappointedNumber += 1;
      // });
    }
  }

  void clickKudosButton(int index) {
      setState(() {
        if (feeds![index].isFelt == 0) {
          feeds![index].feel += 1;
          feeds![index].isFelt = 1;
        } else {
          feeds![index].feel -= 1;
          feeds![index].isFelt = 0;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          NewFeed();
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: StadiumBorder(),
                        ),
                        child: const Text(
                          "Bạn Đang Nghĩ Gì ?",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.pending), Text("Status")],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                left: BorderSide(color: Colors.grey),
                                right: BorderSide(color: Colors.grey))),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.image), Text("Image")],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // onPressed: () { },
                        // style: ButtonStyle(
                        // ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.flag), Text("Event")],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: FutureBuilder<List<Post>>(
          future: FeedService().getFeeds(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              feeds = snapshot.data;
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => FeedBox(
                    post: snapshot.data![index],
                    ontap: () => clickKudosButton(index)),
              );
            } else {
              return Container();
            }
          },
        ))
      ],
    ));
  }
}
