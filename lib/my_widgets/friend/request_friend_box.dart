import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/models/notification_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:facebook_app/services/notification_services.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RequestFriendBox extends StatefulWidget {
  final RequestFriendModel friend;
  final VoidCallback onRemoveItem;
  const RequestFriendBox({
    super.key,
    required this.friend,
    required this.onRemoveItem,
  });

  @override
  State<RequestFriendBox> createState() => _RequestFriendBoxState();
}

class _RequestFriendBoxState extends State<RequestFriendBox> {
  void _onRejectRequest(BuildContext context) async {
    final success = await FriendService(context: context)
        .setAcceptFriend(widget.friend.id, 0);
    if (success) {
      setState(() {
        widget.friend.isReject = true;
      });
    }
  }

  void _onAcceptRequest(BuildContext context) async {
    final AppService appService =
        Provider.of<AppService>(context, listen: false);
    final success = await FriendService(context: context)
        .setAcceptFriend(widget.friend.id, 1);
    if (success) {
      // send noti
      NotificationServices().sendNotificationToTopic(
          topic: widget.friend.id.toString(),
          notification: NotificationModel(
              title: "Anti facebook",
              message: "${appService.username} đã chấp nhận lời mời kết bạn",
              data: AccepetFriendNotiModel(
                      friendId: int.parse(appService.uidLoggedIn),
                      avatar: appService.avatar)
                  .toMap()));

      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: "Đã chấp nhận lời mời kết bạn");
      widget.onRemoveItem();
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
                    context
                        .push("/authenticated/personalPage/${widget.friend.id}")
                  },
              child: MyImage(
                imageUrl: widget.friend.avatar,
                height: 90,
                width: 90,
              ))),
      const SizedBox(
        width: 12,
      ),
      // info and button
      Expanded(
        flex: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // name and time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.friend.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  getDifferenceTime(
                      DateTime.now(), DateTime.parse(widget.friend.created)),
                  style: const TextStyle(color: Colors.grey),
                )
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
                    "${widget.friend.sameFriends} bạn chung",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),

            const SizedBox(
              height: 6,
            ),
            // button
            widget.friend.isReject
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Đã gỡ lời mời kết bạn",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onAcceptRequest(context);
                          },
                          style: ElevatedButton.styleFrom(),
                          child: const Text("Chấp nhận"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _onRejectRequest(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300]),
                          child: const Text(
                            "Từ chối",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
      if (widget.friend.isReject)
        IconButton(
          icon: Icon(
            Icons.more_horiz,
            size: 25,
            color: Colors.grey[600],
          ),
          onPressed: () {
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
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                  "xác nhận chặn ${widget.friend.username}"),
                              // content: const Text(
                              //     'AlertDialog description'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // block user
                                    final success =
                                        await FriendService(context: context)
                                            .setBlocksFriend(
                                                widget.friend.id.toString());
                                    if (success) {
                                      // ignore: use_build_context_synchronously
                                      showSnackBar(
                                          context: context,
                                          msg:
                                              "Đã chặn tài khoản ${widget.friend.username}");
                                      widget.onRemoveItem();
                                    }
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.lock,
                              size: 30,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "chặn ${widget.friend.username}",
                              style: const TextStyle(
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
        ),
    ]);
  }
}
