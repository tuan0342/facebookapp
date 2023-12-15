import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/my_widgets/personal/personal_friend.dart';
import 'package:facebook_app/my_widgets/post/feed_item.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/personal/personal_detail.dart';
import 'package:facebook_app/my_widgets/personal/personal_images.dart';
import 'package:facebook_app/my_widgets/personal/personal_info.dart';
import 'package:facebook_app/my_widgets/personal/personal_skeleton.dart';
import 'package:facebook_app/services/feed_service.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:facebook_app/services/user_service.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  final String uid;
  const PersonalPage({super.key, required this.uid});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Profile profile = const Profile(
      id: "",
      username: "",
      created: "",
      description: "",
      avatar: "",
      imageCover: "",
      link: "",
      address: "",
      city: "",
      country: "",
      listing: "",
      isFriend: "",
      online: "",
      coins: "");
  List<FriendModel> friends = [];
  late List<Post> feeds = [];

  bool isLoadingProfile = false;
  bool isLoadingFriend = false;
  bool isLoadingNewFeeds = false;

  final ScrollController controller = ScrollController();
  int lastId = 0;
  int indexPost = 0;
  int countPost = 20;
  bool isEndPosts = false;

  bool isEndFriend = false;
  int totalFriend = 0;

  @override
  void initState() {
    super.initState();
    getProfile();
    controller.addListener(handleScrolling);
    getNewFeed();
    onLoadFriend(context);
  }

  void handleScrolling() {
    // if (controller.position.pixels == controller.position.maxScrollExtent) {
    if (controller.position.extentAfter == 0) {
      getNewFeed();
    }
  }

  void getNewFeed() async {
    if (!isEndPosts) {
      setState(() {
        isLoadingNewFeeds = true;
      });

      try {
        final data = await FeedService(context: context).getPersonalFeeds(
            context: context,
            campaign_id: "1",
            count: countPost.toString(),
            in_campaign: "1",
            index: indexPost.toString(),
            last_id: "0",
            latitude: "1.0",
            longitude: "1.0",
            uid: widget.uid);

        if (data["posts"].isEmpty) {
          setState(() {
            isEndPosts = true;
          });
        } else {
          setState(() {
            feeds.addAll(data["posts"]);
            lastId = int.parse(data["lastId"]);
            indexPost += countPost;
          });
        }
      } catch (err) {
        debugPrint("exception $err");
      } finally {
        setState(() {
          isLoadingNewFeeds = false;
        });
      }
    }
  }

  void getProfile() async {
    setState(() {
      isLoadingProfile = true;
    });
    final profile_ =
        await UserService().getProfile(context: context, uid: widget.uid);
    setState(() {
      profile = profile_;
      isLoadingProfile = false;
    });
  }

  void clickKudosButton(int index) {
    setState(() {
      if (feeds[index].isFelt == 0) {
        feeds[index].feel += 1;
        feeds[index].isFelt = 1;
      } else {
        feeds[index].feel -= 1;
        feeds[index].isFelt = 0;
      }
    });
  }

  void onLoadFriend(BuildContext context) async {
    if (!isEndFriend) {
      setState(() {
        isLoadingFriend = true;
      });
      final data =
          await FriendService(context: context).getFriends(0, 6, widget.uid);

      if (data["friends"].isEmpty) {
        setState(() {
          isEndFriend = true;
        });
      } else {
        setState(() {
          friends.addAll(data["friends"]);
        });
      }

      setState(() {
        isLoadingFriend = false;
      });
    }
  }

  void changeIsFriend() {
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: const MyAppBar(title: "Trang cá nhân"),
        body: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            controller: controller,
            child: isLoadingProfile || isLoadingProfile || isLoadingFriend
                ? const PersonalSkeleton()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PersonalImages(
                        profile: profile,
                        contextPage: context,
                      ),
                      PersonalInfo(
                        profile: profile,
                        contextPage: context,
                        changeIsFriend: changeIsFriend,
                      ),
                      Container(
                        height: 20,
                        margin: const EdgeInsets.only(top: 10),
                        color: const Color(0xFFc9ccd1),
                      ),
                      PersonalDetail(
                        profile: profile,
                        contextPage: context,
                      ),

                      PersonalFriend(friends: friends, contextPage: context, 
                        uid: profile.id, profile: profile,),

                      Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 10),
                        color: const Color(0xFFc9ccd1),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      personalNewFeed(),
                    ],
                  ),
          ),
        ));
  }

  Widget personalNewFeed() {
    return feeds.isEmpty
        ? Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            child: const Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Chưa có bài đăng!',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ))
        : Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: feeds.length,
              itemBuilder: (context, index) =>Container(
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 4, color: Colors.grey))),
                              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                              child: FeedItem(
                                postData: feeds[index],
                              ),
                            ),
              
            ),
            if (isLoadingNewFeeds) const Padding(padding: EdgeInsets.only(top: 20), child: CircularProgressIndicator()),
            Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    isEndPosts ? 'Hết bài đăng!' : '',
                    style: const  TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              )
            )
          ],
        );
  }

  @override
  void dispose() {
    controller.removeListener(handleScrolling);
    super.dispose();
  }
}
