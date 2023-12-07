import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/my_widgets/feed_box.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/personal/personal_detail.dart';
import 'package:facebook_app/my_widgets/personal/personal_friend.dart';
import 'package:facebook_app/my_widgets/personal/personal_images.dart';
import 'package:facebook_app/my_widgets/personal/personal_info.dart';
import 'package:facebook_app/my_widgets/personal/personal_skeleton.dart';
import 'package:facebook_app/services/feed_service.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:facebook_app/services/user_service.dart';
import 'package:flutter/material.dart';

const COUNT = "10";

class PersonalPage extends StatefulWidget {
  final String uid;
  const PersonalPage({super.key, required this.uid});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Profile profile = const Profile(id: "", username: "", created: "", description: "", avatar: "",
      imageCover: "", link: "", address: "", city: "", country: "", listing: "", isFriend: "",
      online: "", coins: "");
  List<FriendModel> friends = [];
  late List<Post> feeds = [];

  bool isLoadingProfile = false;
  bool isLoadingFriend = false;
  bool isLoadingNewFeeds = false;

  final ScrollController controller = ScrollController();
  int lastId = 0;
  int countPost = 0;
  
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
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      getMoreNewFeed();
    }
  }

  void getNewFeed() async {
    setState(() {
      isLoadingNewFeeds = true;
    });

    feeds = await FeedService().getPersonalFeeds(context: context, campaign_id: "1", count: COUNT, 
      in_campaign: "1", index: "0", last_id: lastId.toString(), latitude: "1.0", longitude: "1.0", uid: widget.uid);

    setState(() {
      lastId = feeds[feeds.length - 1].id;
      countPost = countPost + feeds.length;
      isLoadingNewFeeds = false;
    });
  }

  void getMoreNewFeed() async {

  }

  void getProfile() async {
    setState(() {
      isLoadingProfile = true;
    });
    final profile_ = await UserService().getProfile(context: context, uid: widget.uid);
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
                    PersonalImages(profile: profile, contextPage: context,),
                    PersonalInfo(profile: profile, contextPage: context,),

                    Container(
                      height: 20,
                      margin: const EdgeInsets.only(top: 10),
                      color: const Color(0xFFc9ccd1),
                    ),

                    PersonalDetail(profile: profile, contextPage: context,),
                    PersonalFriend(friends: friends, contextPage: context,),

                    Container(
                      height: 20,
                      margin: const EdgeInsets.only(top: 10),
                      color: const Color(0xFFc9ccd1),
                    ),
                    
                    const SizedBox(height: 10,),     

                    personalNewFeed(),
                  ],
                ),
          ),
        )
      );
  }

  Widget personalNewFeed() {
    return feeds.isEmpty 
      ? Container(
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width,
        child: const Column(
          children: [
            SizedBox(height: 20,),
            Text('Bạn chưa đăng bài!', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),),
            SizedBox(height: 30,)
          ],
        )
      )
      : ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: feeds.length,
          itemBuilder: (context, index) => FeedBox(
            post: feeds[index],
            ontap: () => clickKudosButton(index),
          ),
        );
  }

  @override
  void dispose() {
    controller.removeListener(handleScrolling);
    super.dispose();
  }
}
