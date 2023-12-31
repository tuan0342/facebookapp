import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/my_widgets/friend/request_friend_box.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/friend_service.dart';
import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RequestFriendsPage extends StatefulWidget {
  const RequestFriendsPage({super.key});

  @override
  State<RequestFriendsPage> createState() => _RequestFriendsPageState();
}

class _RequestFriendsPageState extends State<RequestFriendsPage> {
  late ScrollController _scrollController;
  int index = 0;
  static const int count = 20;
  List<RequestFriendModel> requests = [];
  int total = 0;
  bool isEnd = false;
  bool isLoading = false;

  void _onShowSuggest(BuildContext context) async {
    context.push("/authenticated/friends/suggests");
  }

  void _onShowFriends(BuildContext context) async {
    final appService = Provider.of<AppService>(context, listen: false);
    context.push("/authenticated/friends/${appService.uidLoggedIn}");
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0) {
      onGetRequest(context);
    }
  }

  void onGetRequest(BuildContext context) async {
    if (!isEnd) {
      setState(() {
        isLoading = true;
      });
      final data =
          await FriendService(context: context).getRequests(index, count);

      if (data["requests"].isEmpty) {
        setState(() {
          isEnd = true;
        });
      } else {
        setState(() {
          requests.addAll(data["requests"] as Iterable<RequestFriendModel>);
          total = data["total"];
        });
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  void _onShowSearchScreen(BuildContext context) async {
    context.push("/authenticated/search/user");
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    onGetRequest(context);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 16, bottom: 0),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                        child: Text(
                      "Bạn bè",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )),
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: InkWell(
                        onTap: () {
                          _onShowSearchScreen(context);
                        },
                        child: const Icon(Icons.search),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        _onShowSuggest(context);
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                      child: const Text(
                        "Gợi ý",
                        style: TextStyle(color: Colors.black),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        _onShowFriends(context);
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                      child: const Text(
                        "Tất cả bạn bè",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text("Lời mời kết bạn: "),
                Text(
                  total >= requests.length
                      ? total.toString()
                      : requests.length.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          listRequestWidget(),
        ]),
      ),
    );
  }

  Widget listRequestWidget() {
    return requests.isEmpty
        ? const Text("Không có lời mời kết bạn")
        : Expanded(
            child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: requests.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: RequestFriendBox(
                      friend: requests[index],
                      onRemoveItem: () {
                        setState(() {
                          requests.removeAt(index);
                          total -= 1;
                        });
                      },
                    ),
                  ),
                ),
              ),
              if (isLoading) const CircularProgressIndicator()
            ],
          ));
  }
}
