import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/my_widgets/friend_box.dart';
import 'package:facebook_app/services/friend_service.dart';
import "package:flutter/material.dart";

class Friends extends StatefulWidget {
  Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  late ScrollController _scrollController;
  int index = 0;
  static const int count = 20;
  List<FriendModel> requests = [];
  int total = 0;
  bool isEnd = false;
  bool isLoading = false;

  void _onShowSuggest(BuildContext context) async {
    final data =
        await FriendService(context: context).getSuggestFriends(index, 5);
    debugPrint("data: $data");
  }

  void _onShowFriends(BuildContext context) async {
    final data = await FriendService(context: context).getFriends(index, 5);
    debugPrint("data: $data");
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

      debugPrint("data: $data");
      if (data["requests"].isEmpty) {
        setState(() {
          isEnd = true;
        });
      } else {
        setState(() {
          requests.addAll(data["requests"]);
          total = data["total"];
        });
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    onGetRequest(context);
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
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Bạn bè",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                        "Bạn bè",
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
                  total.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                  itemBuilder: (context, index) => FriendBox(
                    friend: requests[index],
                    remove: () {
                      setState(() {
                        requests.removeAt(index);
                        total -= 1;
                      });
                    },
                  ),
                ),
              ),
              if (isLoading) const CircularProgressIndicator()
            ],
          ));
  }
}
