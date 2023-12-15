import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PersonalInfo extends StatefulWidget {
  final Profile profile;
  final BuildContext contextPage;
  const PersonalInfo({super.key, required this.profile, 
                      required this.contextPage});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  bool isSendRequest = false;  // false: chưa gửi kb, true: đã gửi kb
  bool isFriend = true;  // true: đang là bạn bè, false: đã hủy kết bạn

  @override
  void initState() {
    super.initState();
    setState(() {
      if(widget.profile.isFriend == '0') isSendRequest = false;
      if(widget.profile.isFriend == '1') isSendRequest = true;
      if(widget.profile.isFriend == '2') isSendRequest = true;
    });
  }

  void onAddFriend(BuildContext context) async {
    final isSendRequested = await FriendService(context: context)
        .setRequestFriend(int.parse(widget.profile.id));

    if (isSendRequested) {
      setState(() {
        isSendRequest = true;
      });
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: "Đã gửi lời mời kết bạn");
    }
  }

  void onCancelSendRequest(BuildContext context) async {
    final isCancelSuccess = await FriendService(context: context)
        .delRequestFriend(int.parse(widget.profile.id));

    if (isCancelSuccess) {
      setState(() {
        isSendRequest = false;
      });
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: "Đã hủy lời mời kết bạn");
    }
  }

  void onUnfriend(BuildContext context) async {
    final isSendRequested = await FriendService(context: context)
        .unFriend(int.parse(widget.profile.id));

    if (isSendRequested) {
      setState(() {
        isSendRequest = false;
        isFriend = false;
      });
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: "Đã hủy kết bạn");
    }
  }

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);

    void blockFriend(BuildContext context) async {
      final success = await FriendService(context: context)
              .setBlocksFriend(widget.profile.id);
      if (success) {
        // ignore: use_build_context_synchronously
        showSnackBar(
            context: context,
            msg:
                "Đã chặn tài khoản ${widget.profile.username}");
        if (!mounted) return;
        widget.contextPage.pop(context);
      }
      // context.pushReplacement("/authenticated/personalPage/${appService.uidLoggedIn}");
    }

    return  Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.profile.username, 
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                
                widget.profile.description.isNotEmpty 
                  ? const SizedBox(height: 10,) 
                  : const SizedBox(height: 0,),
                
                widget.profile.description.isNotEmpty 
                  ? Text(widget.profile.description,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)) 
                  : const SizedBox(height: 5,),
                
                // is me
                if(widget.profile.id == appService.uidLoggedIn) 
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: widget.profile.description.isNotEmpty ? 10.0 : 0.0, right: 10),
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              context.push(
                                '/authenticated/personalPage/${widget.profile.id}/editPersonalInfoPage', 
                                extra: widget.profile);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFe5e6eb)),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(padding: EdgeInsets.only(right: 5),
                                    child: Icon(Icons.edit,color: Colors.black,size: 20),
                                  ),
                                  Text(
                                    "Chỉnh sửa trang cá nhân",
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, 
                                                      color: Colors.black)),
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top:
                              widget.profile.description.isNotEmpty ? 10.0 : 0.0,
                        ),
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push(
                                '/authenticated/personalPage/${widget.profile.id}/settingPersonalPage',
                                extra: widget.profile);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFe5e6eb)),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Icon(Icons.more_horiz,
                                color: Colors.black, size: 28),
                          ),
                        ),
                      ),
                    ],
                  ),

                // not me + is friend
                if(widget.profile.id != appService.uidLoggedIn 
                  && widget.profile.isFriend == '1' && isSendRequest && isFriend)
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: widget.profile.description.isNotEmpty? 10.0 : 0.0,),
                        height: 40,
                        width: 160,
                        child: ElevatedButton(
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
                                        onPressed: () {
                                          onUnfriend(widget.contextPage);
                                          Navigator.pop(context);
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.person_remove,
                                              size: 32,
                                              color: Colors.black,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Hủy kết bạn",
                                              style: TextStyle(fontSize: 16, color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      TextButton(
                                        onPressed: () {
                                          blockFriend(widget.contextPage);
                                          Navigator.pop(context);
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.person_off,
                                              size: 32,
                                              color: Colors.black,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Chặn",
                                              style: TextStyle(fontSize: 16, color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFFe5e6eb)),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.only(right: 10),
                                child: Icon(Icons.how_to_reg,color: Colors.black,size: 24),
                              ),
                              Text("Bạn bè", style: TextStyle(
                                fontSize: 16,
                                fontWeight:FontWeight.bold,
                                color: Colors.black)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                
                // not me + is not friend + not send request 
                if((widget.profile.id != appService.uidLoggedIn && 
                      widget.profile.isFriend == '0' && !isSendRequest) 
                  || (widget.profile.id != appService.uidLoggedIn && 
                      widget.profile.isFriend == '2' && !isSendRequest) 
                  || (widget.profile.isFriend == '1' && !isFriend && !isSendRequest))
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: widget.profile.description.isNotEmpty? 10.0 : 0.0,),
                        height: 40,
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {
                            onAddFriend(widget.contextPage);
                          },
                          style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF0865fe)),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.person_add,color: Colors.white,size: 24),
                              ),
                              Text("Thêm bạn bè", style: TextStyle(
                                fontSize: 16,
                                fontWeight:FontWeight.bold,
                                color: Colors.white)
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: widget.profile.description.isNotEmpty? 10.0 : 0.0, left: 10),
                        height: 40,
                        child: ElevatedButton(
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
                                        onPressed: () {
                                          blockFriend(widget.contextPage);
                                          Navigator.pop(context);
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.person_off,
                                              size: 32,
                                              color: Colors.black,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Chặn",
                                              style: TextStyle(fontSize: 16, color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFFe5e6eb)),
                          child: const Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                            size: 28
                          ),
                        ),
                      ),
                    ],
                  ),

                // not me + is not friend + sent request 
                if((widget.profile.id != appService.uidLoggedIn 
                    && widget.profile.isFriend == '2' && isSendRequest)
                  || (widget.profile.id != appService.uidLoggedIn && 
                    widget.profile.isFriend == '0' && isSendRequest)
                  || (widget.profile.id != appService.uidLoggedIn &&
                    widget.profile.isFriend == '1' && !isFriend && isSendRequest))
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: widget.profile.description.isNotEmpty? 10.0 : 0.0,),
                        height: 40,
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {
                            onCancelSendRequest(widget.contextPage);
                          },
                          style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFFe5e6eb)),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.only(right: 10),
                                child: Icon(Icons.person_remove,color: Colors.black,size: 24),
                              ),
                              Text("Hủy lời mời", style: TextStyle(
                                fontSize: 16,
                                fontWeight:FontWeight.bold,
                                color: Colors.black)
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: widget.profile.description.isNotEmpty? 10.0 : 0.0, left: 10),
                        height: 40,
                        child: ElevatedButton(
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
                                        onPressed: () {
                                          blockFriend(widget.contextPage);
                                          Navigator.pop(context);
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.person_off,
                                              size: 32,
                                              color: Colors.black,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Chặn",
                                              style: TextStyle(fontSize: 16, color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFFe5e6eb)),
                          child: const Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                            size: 28
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            )
          ),
        ),
      ],
    );
  }
}