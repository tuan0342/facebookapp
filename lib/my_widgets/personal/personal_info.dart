import 'package:facebook_app/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class PersonalInfo extends StatelessWidget {
  Profile profile;
  PersonalInfo({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(profile.username, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                Text(profile.description,style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: profile.description.isNotEmpty ? 10.0 : 0.0, right: 10),
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              context.push('/authenticated/personalPage/${profile.id}/editPersonalInfoPage', extra: profile);
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
                                  Text("Chỉnh sửa trang cá nhân", style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:FontWeight.bold,
                                    color: Colors.black)
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: profile.description.isNotEmpty? 10.0 : 0.0,),
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push('/authenticated/personalPage/${profile.id}/settingPersonalPage',extra: profile);
                          },
                          style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFFe5e6eb)),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.black,
                              size: 28
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ),
          ),
      ],
    );
  }
}