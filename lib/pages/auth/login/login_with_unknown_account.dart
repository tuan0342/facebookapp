import 'package:email_validator/email_validator.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LogInUnknownPage extends StatefulWidget {
  const LogInUnknownPage({super.key});

  @override
  State<LogInUnknownPage> createState() => _LogInUnknownPageState();
}

class _LogInUnknownPageState extends State<LogInUnknownPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final authService = Provider.of<AuthService>(context, listen: false);
      // call api here
      await authService.logInWithApi(
          context: context,
          email: emailController.text,
          password: passwordController.text);

      setState(() {
        isLoading = false;
      });
    }
  }

  void forgetPasswordClick() {
    context.go("/auth");
  }

  void createNewAccountClick() {
    context.go("/auth/register");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: ""),
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: SizedBox.fromSize(
                size: const Size.fromRadius(50), // Image radius
                child: Image.asset("assets/images/af_logo.png"),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: "Email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập email của bạn!';
                      }
                      if (!EmailValidator.validate(value)) {
                        return "Email không đúng định dạng!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Mật khẩu"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu của bạn!';
                      }
                      if (value.length < 6 || value.length > 10) {
                        return "Mật khẩu phải có từ 6 tới 10 kí tự";
                      }
                      return null;
                    },
                  ),
                ),
                isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox(),
                MyFilledButton(
                    isDisabled: isLoading,
                    title: "Đăng nhập",
                    cbFunction: handleLogin,
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(200, 50)))),
                MyTextButton(
                  title: "Quên mật khẩu?",
                  textStyle: const TextStyle(color: Colors.black),
                  cbFunction: forgetPasswordClick,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: MyFilledButton(
                  isDisabled: false,
                  title: "Đăng ký",
                  textStyle: const TextStyle(color: Colors.blueAccent),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.transparent,
                  ),
                  cbFunction: createNewAccountClick),
            ),
          ),
        )
      ]),
    );
  }
}
