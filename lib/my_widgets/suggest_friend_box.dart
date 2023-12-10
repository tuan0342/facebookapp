import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuggestFriendBox extends StatefulWidget {
  final SuggestFriendModel friend;
  final VoidCallback onRemove;
  const SuggestFriendBox(
      {super.key, required this.friend, required this.onRemove});

  @override
  State<SuggestFriendBox> createState() => _SuggestFriendBoxState();
}

class _SuggestFriendBoxState extends State<SuggestFriendBox> {
  void _onRemoveSuggest(BuildContext context) async {
    showSnackBar(context: context, msg: "Đã gỡ gợi ý");
    widget.onRemove();
  }

  void _onAddFriend(BuildContext context) async {
    final isSendRequested = await FriendService(context: context)
        .setRequestFriend(widget.friend.id);

    if (isSendRequested) {
      setState(() {
        widget.friend.isSendRequest = true;
      });
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: "Đã gửi lời mời kết bạn");
    }
  }

  void _onCancelSendRequest(BuildContext context) async {
    final isCancelSuccess = await FriendService(context: context)
        .delRequestFriend(widget.friend.id);

    if (isCancelSuccess) {
      setState(() {
        widget.friend.isSendRequest = false;
      });
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: "Đã hủy lời mời kết bạn");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // avatar
      Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () => {
              context.push("/authenticated/personalPage/${widget.friend.id}")
            },
            child: MyImage(
              imageUrl: widget.friend.avatar,
              height: 90,
              width: 90,
            ),
          )),
      const SizedBox(
        width: 12,
      ),
      // info and button
      Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // name and time
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.friend.username,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              // bạn chung
              if (widget.friend.sameFriends > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.friend.sameFriends > 0
                          ? "${widget.friend.sameFriends} bạn chung"
                          : "",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

              const SizedBox(
                height: 6,
              ),
              // button
              widget.friend.isSendRequest
                  ? Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Đã gửi lời mời kết bạn",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _onCancelSendRequest(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300]),
                                child: const Text(
                                  "Hủy",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _onAddFriend(context);
                            },
                            style: ElevatedButton.styleFrom(),
                            child: const Text("Thêm bạn bè"),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _onRemoveSuggest(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300]),
                            child: const Text(
                              "Gỡ",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ))
    ]);
  }
}
