import 'package:email_validator/email_validator.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleRegister() async {
    if (_formKey.currentState!.validate()) {
      final authService = Provider.of<AuthService>(context, listen: false);
      // call api here
      authService.register(
          context: context,
          email: emailController.text,
          password: passwordController.text);
    }
  }

  void logInClick() {
    context.go("/auth/logInUnknown");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: ""),
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Image.asset(
            "assets/images/logo.png",
            width: 80,
            height: 80,
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
                        return 'Please enter your email';
                      }
                      if (!EmailValidator.validate(value)) {
                        return "Email is invalid!";
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
                        labelText: "Password"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length <6 || value.length > 10) {
                        return "Password must be between 6 and 10 characters";
                      }
                      return null;
                    },
                  ),
                ),
                MyFilledButton(
                    isDisabled: false,
                    title: "Register",
                    cbFunction: handleRegister,
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(200, 50)))),
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
                  title: "Login",
                  textStyle: const TextStyle(color: Colors.blueAccent),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.transparent,
                  ),
                  cbFunction: logInClick),
            ),
          ),
        )
      ]),
    );
  }
}
