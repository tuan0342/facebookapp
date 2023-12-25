import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SettingPersonalPage extends StatefulWidget {
  final Profile profile;
  const SettingPersonalPage({super.key, required this.profile});

  @override
  State<SettingPersonalPage> createState() => _SettingPersonalPageState();
}

class _SettingPersonalPageState extends State<SettingPersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Cài đặt trang cá nhân"),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFFc9ccd1)),
              ),
            ),

            TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                ),
                onPressed: () {
                  context.push(
                      '/authenticated/personalPage/${widget.profile.id}/editPersonalInfoPage',
                      extra: widget.profile);
                },
                child: const Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.black,
                          size: 34,
                        )),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            'Chỉnh sửa trang cá nhân',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )),
                  ],
                )),
            const SizedBox(
              height: 1.0,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFFc9ccd1)),
              ),
            ),

            TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                ),
                onPressed: () {
                  context.push("/authenticated/search/post");
                },
                child: const Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                        child: Icon(
                          Icons.search_outlined,
                          color: Colors.black,
                          size: 34,
                        )),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            'Tìm kiếm trên trang cá nhân',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )),
                  ],
                )),
            const SizedBox(
              height: 10.0,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFFc9ccd1)),
              ),
            ),

            // Liên kết đến trang cá nhân
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Liên kết đến trang cá nhân của bạn',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Liên kết của riêng bạn trên Facebook.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 1.0,
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xFFc9ccd1)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  // link
                  Text(
                    widget.profile.link.isEmpty
                        ? 'Bạn không có đường link đến trang cá nhân'
                        : widget.profile.link,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                          text: widget.profile.link.isEmpty
                              ? 'Bạn không có đường link đến trang cá nhân'
                              : widget.profile.link));
                      showSnackBar(
                          context: context,
                          msg: "Đã copy liên kết",
                          timeShow: 1000);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFe5e6eb)),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Sao chép liên kết",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
