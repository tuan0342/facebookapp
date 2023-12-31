import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/my_widgets/my_text.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInKnownPage extends StatefulWidget {
  const LogInKnownPage({super.key});

  @override
  State<LogInKnownPage> createState() => _LogInKnownPageState();
}

class _LogInKnownPageState extends State<LogInKnownPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    TextEditingController passwordController = TextEditingController();

    void logIn() async {
      setState(() {
        isLoading = true;
      });
      await authService.logInWithApi(
          context: context,
          email: appService.email,
          password: passwordController.text);
      setState(() {
        isLoading = false;
      });
    }

    void forgotPassword() {
      showSnackBar(
          context: context,
          msg: 'Hiện chúng tôi chưa hỗ trợ tính năng này',
          timeShow: 1500);
    }

    return Scaffold(
      appBar: const MyAppBar(title: ""),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 80.0, 16.0, 0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    MyImage(
                      imageUrl: appService.avatar,
                      height: 70,
                      width: 70,
                      shape: BoxShape.rectangle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: MyText(
                        title: appService.username,
                        type: "labelLarge",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: SizedBox(
                        width: 250,
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                              labelText: "Mật khẩu"),
                        ),
                      ),
                    ),
                    isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: MyFilledButton(
                          isDisabled: isLoading,
                          title: "Đăng nhập",
                          cbFunction: logIn),
                    ),
                    MyTextButton(
                        isDisabled: false,
                        title: "Quên mật khẩu?",
                        cbFunction: forgotPassword),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
