import 'dart:convert';

import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/rest_api/rest_api.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerifyAccountPage extends StatefulWidget {
  final String email;
  const VerifyAccountPage({super.key, required this.email});

  @override
  State<VerifyAccountPage> createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {
  String verifyCode = "";
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController verifyCodeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getVerifyCode();
  }

  void getVerifyCode() async {
    setState(() {
      isLoading = true;
    });
    final Map<String, String> body = {
      "email": widget.email,
    };

    final response = await postMethod(endpoind: "get_verify_code", body: body);
    if (response.statusCode == 200) {
      setState(() {
        verifyCode = jsonDecode(response.body)["data"]["verify_code"];
      });
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: "Có lỗi xảy ra khi lấy mã xác thực");
    }

    setState(() {
      isLoading = false;
    });
  }

  void verifyAccount() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final body = {
        "email": widget.email,
        "code_verify": verifyCodeController.text
      };
      final response =
          await postMethod(endpoind: "check_verify_code", body: body);

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, msg: "Xác thực thành công");
        // ignore: use_build_context_synchronously
        context.go("/auth/logInUnknown");
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, msg: "Có lỗi xảy ra khi xác thực tài khoản");
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "Verify Account",
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Code của bạn: "),
                  Text(
                    verifyCode,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Text("Vui lòng nhập code vào ô bên dưới"),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: verifyCodeController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: "Verify Code"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter verify code';
                      }
                      if (value
                          .contains(RegExp(r'[A-Z]', caseSensitive: false))) {
                        return 'Code just only digits';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              MyFilledButton(
                  isDisabled: isLoading,
                  title: "Verify Account",
                  cbFunction: verifyAccount,
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(200, 50)))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  height: 10,
                  color: Colors.blueGrey[500],
                ),
              ),
              MyFilledButton(
                  isDisabled: isLoading,
                  title: "Get new code",
                  cbFunction: getVerifyCode,
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(200, 50)))),
              const SizedBox(
                height: 10,
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox(
                      height: 0,
                    )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyFilledButton(
                isDisabled: false,
                title: "Verify after, go to login",
                cbFunction: () {
                  context.go("/auth/loginUnknown");
                },
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size(200, 50)))),
          ),
        ],
      ),
    );
  }
}
