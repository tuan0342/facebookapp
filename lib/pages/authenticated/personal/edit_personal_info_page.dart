import 'dart:io';

import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/personal/edit_personal/edit_avatar.dart';
import 'package:facebook_app/my_widgets/personal/edit_personal/edit_cover.dart';
import 'package:facebook_app/my_widgets/personal/edit_personal/edit_describe.dart';
import 'package:facebook_app/my_widgets/personal/edit_personal/edit_detail.dart';
import 'package:facebook_app/my_widgets/personal/edit_personal/edit_link.dart';
import 'package:facebook_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPersonalInfoPage extends StatefulWidget {
  final Profile profile;
  const EditPersonalInfoPage({super.key, required this.profile});

  @override
  State<EditPersonalInfoPage> createState() => _EditPersonalInfoPageState();
}

class _EditPersonalInfoPageState extends State<EditPersonalInfoPage> {
  final picker = ImagePicker();
  var fileAvatar = File('');
  var fileCover = File('');
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  bool isEditDescription = false;
  bool isEditDetail = false;
  bool isEditLink = false;

  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.profile.description;
    cityController.text = widget.profile.city;
    addressController.text = widget.profile.address;
    linkController.text = widget.profile.link;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Cài đặt trang cá nhân"),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5.0,
                      width: double.infinity,
                      child: DecoratedBox(decoration: BoxDecoration(color: Color(0xFFc9ccd1))),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
                      child: Column(
                        children: [
                          // avatar
                          EditAvatar(profile: widget.profile, fileAvatar: fileAvatar, 
                            contextPage: context, 
                            changeFileAvatar: changeAvt),
                          
                          // cover
                          EditCover(profile: widget.profile, fileCover: fileCover, 
                            contextPage: context, 
                            changeFileCover: changeCover),

                          // description
                          EditDescribe(contextPage: context, profile: widget.profile, 
                            isEditDescription: isEditDescription, descriptionController: descriptionController, 
                            setIsEditDescription: setIsEditDescription),

                          // info
                          EditDetail(contextPage: context, profile: widget.profile, 
                            isEditDetail: isEditDetail, cityController: cityController, 
                            addressController: addressController, setIsEditDetail: setIsEditDetail),

                          // link
                          EditLink(contextPage: context, profile: widget.profile, 
                            isEditLink: isEditLink, linkController: linkController, 
                            setIsEditLink: setIsEditLink),

                          // button
                          isEditDescription || isEditDetail || isEditLink || fileAvatar.path.isNotEmpty || fileCover.path.isNotEmpty
                            ? Column(
                                children: [
                                  const SizedBox(height: 20,),
                                  MyFilledButton(
                                    isDisabled: false,
                                    title: "Lưu thay đổi",
                                    cbFunction: (){
                                      UserService().changeProfile(context: context, 
                                        fullName: widget.profile.username, avatar: fileAvatar,
                                        address: addressController.text, city: cityController.text,
                                        country: widget.profile.country, description: descriptionController.text,
                                        link: linkController.text, cover: fileCover);
                                    },
                                    style: ButtonStyle(
                                      minimumSize:
                                        MaterialStateProperty.all(const Size(240, 50)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        )
                                      )
                                    )
                                  ),
                                  const SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: MyFilledButton(
                                      isDisabled: false,
                                      title: "Hủy bỏ chỉnh sửa",
                                      textStyle: const TextStyle(color: Colors.black),
                                      style: FilledButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Colors.black54),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        minimumSize: const Size(200, 50),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      cbFunction: (){
                                        setState(() {
                                          isEditDetail = false;
                                          isEditDescription = false;
                                          isEditLink = false;
                                          descriptionController.text = widget.profile.description;
                                          cityController.text = widget.profile.city;
                                          addressController.text = widget.profile.address;
                                          linkController.text = widget.profile.link;
                                          fileAvatar = File('');
                                          fileCover = File('');
                                        });
                                      }
                                    ),
                                  )
                                ],
                              ) 
                            : const SizedBox(),
                        ],
                      )
                    ),
                  ],
                ),
              )
            ),
          ]
        )
      ),
    );
  }

  void changeAvt(String path) {
    setState(() {
      fileAvatar = File(path);
    });
  }

  void changeCover(String path) {
    setState(() {
      fileCover = File(path);
    });
  }

  void setIsEditDescription() {
    setState(() {
      isEditDescription = !isEditDescription;
      descriptionController.text = widget.profile.description;
    });
  }

  void setIsEditDetail() {
    setState(() {
      isEditDetail = !isEditDetail;
      cityController.text = widget.profile.city;
      addressController.text = widget.profile.address;
    });
  }

  void setIsEditLink() {
    setState(() {
      isEditLink = !isEditLink;
      linkController.text = widget.profile.link;
    });
  }
}
