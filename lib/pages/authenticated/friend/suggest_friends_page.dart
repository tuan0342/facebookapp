import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/my_widgets/friend/suggest_friend_box.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuggestFriendsPage extends StatefulWidget {
  const SuggestFriendsPage({super.key});

  @override
  State<SuggestFriendsPage> createState() => _SuggestFriendsPageState();
}

class _SuggestFriendsPageState extends State<SuggestFriendsPage> {
  late ScrollController _scrollController;
  List<SuggestFriendModel> suggests = [];
  bool isLoading = false;
  bool isEnd = false;
  int index = 0;
  static const count = 20;

  void onLoad(BuildContext context) async {
    if (!isEnd) {
      setState(() {
        isLoading = true;
      });
      try {
        final suggestResponse = await FriendService(context: context)
            .getSuggestFriends(index, count);
        if (suggestResponse.isEmpty) {
          setState(() {
            isEnd = true;
          });
        } else {
          setState(() {
            suggests.addAll(suggestResponse);
            index = index + count;
          });
        }
      } catch (err) {
        debugPrint("exception $err");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
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

  Future refresh() async {
    setState(() {
      isLoading = false;
      isEnd = false;
      index = 0;
      suggests = [];
    });
    onLoad(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => RefreshIndicator(
            onRefresh: refresh, 
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
                      "Gợi ý",
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
                const Text(
                  "Những người bạn có thể biết",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 14,
                ),
                listSuggestFriends()
              ]),
            ),
          )
        ),
      )
    );
  }

  Widget listSuggestFriends() {
    return suggests.isEmpty
        ? const Center(
            child: Text("Chưa có gợi ý kết bạn"),
          )
        : Expanded(
            child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: suggests.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: SuggestFriendBox(
                      friend: suggests[index],
                      onRemove: () {
                        setState(() {
                          suggests.removeAt(index);
                        });
                      },
                      refresh: refresh,
                      contextPage: context,
                    ),
                  ),
                ),
              ),
              if (isLoading) const CircularProgressIndicator()
            ],
          ));
  }
}
