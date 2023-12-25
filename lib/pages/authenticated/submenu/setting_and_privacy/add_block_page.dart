import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddBlockPage extends StatefulWidget {
  const AddBlockPage({super.key});

  @override
  State<AddBlockPage> createState() => _AddBlockPageState();
}

class _AddBlockPageState extends State<AddBlockPage> {
  late ScrollController _scrollController;
  List<FriendModel> suggests = [];
  List<bool> isBlocksList = [];
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
            List<bool> isBlockListTmp =
                List.filled(suggestResponse.length, false);
            isBlocksList.addAll(isBlockListTmp);
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
                  "Gợi ý",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
                IconButton(
                    onPressed: () {
                      context.push("/authenticated/search/user");
                    },
                    icon: const Icon(Icons.search_rounded)),
              ]),
            ),
            const Divider(
              color: Colors.grey,
            ),
            const Text(
              "Danh sách bạn bè",
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
    return suggests.isEmpty
        ? const Center(
            child: Text("Chưa có gợi ý"),
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
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 10, left: 0, right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyImage(
                            imageUrl: suggests[index].avatar,
                            height: 50,
                            width: 50,
                            shape: BoxShape.rectangle,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            suggests[index].username,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: isBlocksList[index]
                                  ? null
                                  : () {
                                      FriendService(context: context)
                                          .setBlocksFriend(
                                              suggests[index].id.toString());
                                      showSnackBar(
                                          context: context,
                                          msg:
                                              "Đã chặn người dùng: ${suggests[index].username}");
                                      setState(() {
                                        isBlocksList[index] = true;
                                      });
                                    },
                              child: isBlocksList[index]
                                  ? const Text(
                                      'Đã chặn',
                                      style: TextStyle(color: Colors.black87),
                                    )
                                  : const Text('Chặn'))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading) const CircularProgressIndicator()
            ],
          ));
  }
}
