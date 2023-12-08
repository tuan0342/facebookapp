import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginSecurity extends StatefulWidget {
  const LoginSecurity({super.key});

  @override
  State<LoginSecurity> createState() => _LoginSecurityState();
}

class _LoginSecurityState extends State<LoginSecurity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Bảo mật và đăng nhập"),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text('Bảo mật và đăng nhập', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
              ),

              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('Đăng nhập', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              ),
              
              SizedBox(
                width: double.infinity,
                child: TextButton(
                onPressed: (){
                  context.push('/authenticated/menu/setting/loginSecurity/changePassword');
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                  
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Image.asset('assets/images/security_icon.png', height: 35, width: 35)
                      ),
                      const Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Đổi mật khẩu", 
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)
                            ),
                            Text(
                              'Bạn nên sử dụng mật khẩu mạnh mà mình chưa dùng ở đâu khác', 
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromARGB(221, 59, 59, 59))
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Icon(Icons.chevron_right, color: Colors.black54, size: 46), 
                      ),
                    ],
                  )
                ),
              ),
            ],
          )
        )
      ),
    );
  }
}