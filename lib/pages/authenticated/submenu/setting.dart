import 'package:facebook_app/my_widgets/button_submenu.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Cài đặt"),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Text('Cài đặt tài khoản', style: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.w600),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Text('Quản lý thông tin về bạn, các khoản thanh toán và danh bạ của bạn cũng như tài khoản nói chung.', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 72, 72, 72)),),
              ),
              ButtonSubmenu(title: 'Thông tin cá nhân', icon: 'assets/images/personal_information_icon.png', 
                            description: 'Cập nhật tên, số điện thoại và địa chỉ email của bạn.', 
                            route: '/authenticated/menu/setting/personalInformation'
              ),
              ButtonSubmenu(title: 'Chặn', icon: 'assets/images/block_icon.png', 
                            description: 'Một khi bạn chặn ai đó, họ sẽ không xem được nội dung bài đăng và nhắn tin cho bạn.', 
                            route: '/authenticated/menu/setting/personalInformation'
              ),

              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Text('Bảo mật', style: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.w600),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Text('Đổi mật khẩu và thực hiện các hành động khác để tăng cường bảo mật cho tài khoản của bạn.', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 72, 72, 72)),),
              ),
              ButtonSubmenu(title: 'Bảo mật và đăng nhập', icon: 'assets/images/security_icon.png', 
                            description: 'Đổi mật khẩu và thực hiện các hành động khác để tăng cường bảo mật cho tài khoản của bạn.', 
                            route: '/authenticated/menu/setting/loginSecurity'),
            ],
          ),
        )
      ),
    );
  }
}