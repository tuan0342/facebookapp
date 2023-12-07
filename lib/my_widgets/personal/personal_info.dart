import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PersonalInfo extends StatelessWidget {
  Profile profile;
  PersonalInfo({super.key, required this.profile});
  

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);

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
                profile.description.isNotEmpty ? Text(profile.description,style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)) : const SizedBox(height: 5,),
                profile.id == appService.uidLoggedIn ? Row(
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
                ) : const SizedBox(height: 0,),
              ],
            )
          ),
        ),
      ],
    );
  }
}