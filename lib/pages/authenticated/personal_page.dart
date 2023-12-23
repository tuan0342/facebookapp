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
import 'package:skeletonizer/skeletonizer.dart';

class PersonalPage extends StatefulWidget {
  final String uid;
  const PersonalPage({super.key, required this.uid});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Profile profile = const Profile(
      id: "",
      username: "",
      created: "",
      description: "",
      avatar:
          "https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.jpg",
      imageCover:
          "https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.jpg",
      link: "",
      address: "",
      city: "",
      country: "",
      listing: "",
      isFriend: "",
      online: "",
      coins: "");
  List<FriendModel> friends = [];
  List<Post> feeds = [];

  bool isLoadingProfile = false;
  bool isLoadingFriend = false;
  bool isLoadingNewFeeds = false;

  late ScrollController controller;
  // int lastId = 0;
  int indexPost = 0;
  int countPost = 2;
  bool isEndPosts = false;

  int totalFriend = 0;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(handleScrolling);
    getProfile();
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
      setStateIfMounted(() {
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
          setStateIfMounted(() {
            feeds.addAll(data["posts"]);
            // lastId = int.parse(data["lastId"]);
            indexPost += countPost;
          });
        }
      } catch (err) {
        debugPrint("exception $err");
      } finally {
        setStateIfMounted(() {
          isLoadingNewFeeds = false;
        });
      }
    }
  }

  void getProfile() async {
    setStateIfMounted(() {
      isLoadingProfile = true;
    });
    final profile_ =
        await UserService().getProfile(context: context, uid: widget.uid);

    setStateIfMounted(() {
      profile = profile_;
      isLoadingProfile = false;
    });
  }

  void onLoadFriend(BuildContext context) async {
    setStateIfMounted(() {
      isLoadingFriend = true;
    });
    final data =
        await FriendService(context: context).getFriends(0, 6, widget.uid);

    setStateIfMounted(() {
      friends.addAll(data["friends"]);
    });

    setStateIfMounted(() {
      isLoadingFriend = false;
    });
  }

  Future refreshFriend() async {
    setStateIfMounted(() {
      friends = [];
    });
    onLoadFriend(context);
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
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
                      PersonalFriend(
                        friends: friends,
                        contextPage: context,
                        uid: profile.id,
                        profile: profile,
                        refreshFriend: refreshFriend,
                      ),
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
                  itemCount: feeds.length + 1,
                  itemBuilder: (context, index) {
                    if (index == feeds.length) {
                      if (isEndPosts) return Container();
                      return Expanded(
                        child: Skeletonizer(
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 6,
                                  width: double.infinity,
                                  color: Colors.black12,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 44,
                                              height: 44,
                                              child: const Icon(
                                                Icons.add,
                                                size: 44,
                                              )),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 80,
                                                  height: 12,
                                                  color: Colors.black26,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  width: 50,
                                                  height: 8,
                                                  color: Colors.black26,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 28,
                                ),
                                AspectRatio(
                                  aspectRatio: 4 / 3,
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.white12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 4, color: Colors.grey))),
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: FeedItem(
                        postData: feeds[index],
                      ),
                    );
                  }),
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
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ))
            ],
          );
  }

  @override
  void dispose() {
    controller.removeListener(handleScrolling);
    super.dispose();
  }
}
