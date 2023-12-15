import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PersonalInfo extends StatefulWidget {
  final Profile profile;
  final BuildContext contextPage;
  final void Function() changeIsFriend;
  const PersonalInfo({super.key, required this.profile, 
    required this.contextPage, required this.changeIsFriend});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  bool isSendRequest = false;  // false: chưa gửi kb, true: đã gửi kb

  @override
  void initState() {
    super.initState();
    setState(() {
      if(widget.profile.isFriend == '0') isSendRequest = false;
      if(widget.profile.isFriend == '1') isSendRequest = true;
      if(widget.profile.isFriend == '2') isSendRequest = true;
    });
    debugPrint('>> check isSendRequest: ${isSendRequest}');
    debugPrint('>> check isFriend: ${widget.profile.isFriend}');
  }

  void onAddFriend(BuildContext context) async {
    // final isSendRequested = await FriendService(context: context)
    //     .setRequestFriend(int.parse(widget.profile.id));

    // if (isSendRequested) {
    //   setState(() {
    //     isSendRequest = true;
    //   });
    //   // ignore: use_build_context_synchronously
    //   showSnackBar(context: context, msg: "Đã gửi lời mời kết bạn");
    // }
    setState(() {
        isSendRequest = true;
      });
    widget.changeIsFriend();
  }

  void onCancelSendRequest(BuildContext context) async {
    // final isCancelSuccess = await FriendService(context: context)
    //     .delRequestFriend(int.parse(widget.profile.id));

    // if (isCancelSuccess) {
    //   setState(() {
    //     isSendRequest = false;
    //   });
    //   debugPrint('>> check onCancelSendRequest: ${isSendRequest}');
    //   // ignore: use_build_context_synchronously
    //   showSnackBar(context: context, msg: "Đã hủy lời mời kết bạn");
    // }
    setState(() {
        isSendRequest = false;
      });
  }

  void onUnfriend(BuildContext context) async {
    // final isSendRequested = await FriendService(context: context)
    //     .unFriend(int.parse(widget.profile.id));

    // if (isSendRequested) {
    //   setState(() {
    //     isSendRequest = false;
    //   });
    //   // ignore: use_build_context_synchronously
    //   showSnackBar(context: context, msg: "Đã hủy kết bạn");
    // }
    setState(() {
        isSendRequest = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);

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
                  && widget.profile.isFriend == '1' && isSendRequest)
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: widget.profile.description.isNotEmpty? 10.0 : 0.0,),
                        height: 40,
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {
                            onUnfriend(widget.contextPage);
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
                      Container(
                        margin: EdgeInsets.only(top: widget.profile.description.isNotEmpty? 10.0 : 0.0, left: 10),
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {},
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
                
                // not me + is not friend + not send request 
                if((widget.profile.id != appService.uidLoggedIn 
                  && widget.profile.isFriend == '0' && !isSendRequest) ||
                  (widget.profile.id != appService.uidLoggedIn && 
                  widget.profile.isFriend == '2' && !isSendRequest) || 
                  (widget.profile.id != appService.uidLoggedIn && 
                  widget.profile.isFriend == '1' && !isSendRequest))
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
                          onPressed: () {},
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
                    widget.profile.isFriend == '1' && isSendRequest))
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
                              Text("Hủy kết bạn", style: TextStyle(
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
                          onPressed: () {},
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

// ignore: must_be_immutable
// class PersonalInfo extends StatelessWidget {
//   Profile profile;
//   final BuildContext contextPage;
//   PersonalInfo({super.key, required this.profile, required this.contextPage});

//   @override
//   Widget build(BuildContext context) {
//     final appService = Provider.of<AppService>(context, listen: false);

//     return Row(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(profile.username, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                
//                 profile.description.isNotEmpty ? const SizedBox(height: 10,) : const SizedBox(height: 0,),
                
//                 profile.description.isNotEmpty 
//                   ? Text(profile.description,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)) 
//                   : const SizedBox(height: 5,),
                
//                 if(profile.id == appService.uidLoggedIn) 
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           margin: EdgeInsets.only(top: profile.description.isNotEmpty ? 10.0 : 0.0, right: 10),
//                           height: 40,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               context.push('/authenticated/personalPage/${profile.id}/editPersonalInfoPage', extra: profile);
//                             },
//                             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFe5e6eb)),
//                             child: const Padding(
//                               padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Padding(padding: EdgeInsets.only(right: 5),
//                                     child: Icon(Icons.edit,color: Colors.black,size: 20),
//                                   ),
//                                   Text(
//                                     "Chỉnh sửa trang cá nhân",
//                                     style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, 
//                                                       color: Colors.black)),
//                                 ]
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(
//                           top:
//                               profile.description.isNotEmpty ? 10.0 : 0.0,
//                         ),
//                         height: 40,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             context.push(
//                                 '/authenticated/personalPage/${profile.id}/settingPersonalPage',
//                                 extra: profile);
//                           },
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFFe5e6eb)),
//                           child: const Padding(
//                             padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                             child: Icon(Icons.more_horiz,
//                                 color: Colors.black, size: 28),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                 if(profile.id != appService.uidLoggedIn && profile.isFriend == '1')
//                   Row(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(top: profile.description.isNotEmpty? 10.0 : 0.0,),
//                         height: 40,
//                         width: 160,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFFe5e6eb)),
//                           child: const Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(padding: EdgeInsets.only(right: 10),
//                                 child: Icon(Icons.how_to_reg,color: Colors.black,size: 24),
//                               ),
//                               Text("Bạn bè", style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight:FontWeight.bold,
//                                 color: Colors.black)
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: profile.description.isNotEmpty? 10.0 : 0.0, left: 10),
//                         height: 40,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFFe5e6eb)),
//                           child: const Icon(
//                             Icons.more_horiz,
//                             color: Colors.black,
//                             size: 28
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
                
//                 if(profile.id != appService.uidLoggedIn && profile.isFriend == '0')
//                   Row(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(top: profile.description.isNotEmpty? 10.0 : 0.0,),
//                         height: 40,
//                         width: 160,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF0865fe)),
//                           child: const Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(padding: EdgeInsets.only(right: 5),
//                                 child: Icon(Icons.person_add,color: Colors.white,size: 24),
//                               ),
//                               Text("Thêm bạn bè", style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight:FontWeight.bold,
//                                 color: Colors.white)
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: profile.description.isNotEmpty? 10.0 : 0.0, left: 10),
//                         height: 40,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFFe5e6eb)),
//                           child: const Icon(
//                             Icons.more_horiz,
//                             color: Colors.black,
//                             size: 28
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                 if(profile.id != appService.uidLoggedIn && profile.isFriend == '2')
//                   Row(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(top: profile.description.isNotEmpty? 10.0 : 0.0,),
//                         height: 40,
//                         width: 160,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFFe5e6eb)),
//                           child: const Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(padding: EdgeInsets.only(right: 10),
//                                 child: Icon(Icons.person_remove,color: Colors.black,size: 24),
//                               ),
//                               Text("Hủy kết bạn", style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight:FontWeight.bold,
//                                 color: Colors.black)
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: profile.description.isNotEmpty? 10.0 : 0.0, left: 10),
//                         height: 40,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFFe5e6eb)),
//                           child: const Icon(
//                             Icons.more_horiz,
//                             color: Colors.black,
//                             size: 28
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             )
//           ),
//         ),
//       ],
//     );
//   }
// }
