import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/my_widgets/friend_box.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const defaultSort = 0;
const newFirstSort = 1;
const oldFirstSort = 2;

class UserFriendsPage extends StatefulWidget {
  const UserFriendsPage({super.key});

  @override
  State<UserFriendsPage> createState() => _UserFriendsPageState();
}

class _UserFriendsPageState extends State<UserFriendsPage> {
  late ScrollController _scrollController;
  List<FriendModel> friends = [];
  bool isLoading = false;
  bool isEnd = false;
  int index = 0;
  int total = 0;
  int sort = defaultSort;
  static const count = 20;

  void onLoad(BuildContext context) async {
    if (!isEnd) {
      setState(() {
        isLoading = true;
      });
      final data =
          await FriendService(context: context).getFriends(index, count);

      if (data["friends"].isEmpty) {
        setState(() {
          isEnd = true;
        });
      } else {
        setState(() {
          friends.addAll(data["friends"]);
          if (sort == defaultSort || sort == newFirstSort) {
            friends.sort((a, b) => -DateTime.parse(a.created)
                .compareTo(DateTime.parse(b.created)));
          } else {
            friends.sort((a, b) =>
                DateTime.parse(a.created).compareTo(DateTime.parse(b.created)));
          }
          total = data["total"];
        });
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0) {
      onLoad(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    onLoad(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(children: [
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                    child: Text(
                  "Danh sách bạn bè",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
                IconButton(
                    onPressed: () {
                      context.push("/authenticated/search");
                    },
                    icon: const Icon(Icons.search_rounded)),
              ]),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "$total bạn bè",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                MyTextButton(
                  cbFunction: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    sort = defaultSort;
                                    friends.sort((a, b) =>
                                        -DateTime.parse(a.created).compareTo(
                                            DateTime.parse(b.created)));
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.auto_awesome,
                                      size: 32,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Mặc định",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    sort = newFirstSort;
                                    friends.sort((a, b) =>
                                        -DateTime.parse(a.created).compareTo(
                                            DateTime.parse(b.created)));
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.vertical_align_top,
                                      size: 32,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Bạn mới nhất trước tiên",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    sort = oldFirstSort;
                                    friends.sort((a, b) =>
                                        DateTime.parse(a.created).compareTo(
                                            DateTime.parse(b.created)));
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.vertical_align_bottom,
                                      size: 32,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Bạn lâu năm trước tiên",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                  title: "Sắp xếp",
                  textStyle: const TextStyle(fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            listSuggestFriends()
          ]),
        ),
      ),
    );
  }

  Widget listSuggestFriends() {
    return friends.isEmpty
        ? const Center(child: Text("Chưa có bạn bè"))
        : Expanded(
            child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: friends.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: FriendBox(
                      friend: friends[index],
                    ),
                  ),
                ),
              ),
              if (isLoading) const CircularProgressIndicator()
            ],
          ));
  }
}
