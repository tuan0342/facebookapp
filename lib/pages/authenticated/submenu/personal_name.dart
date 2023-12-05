import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/services/user_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';

class PersonalName extends StatefulWidget {
  const PersonalName({super.key});

  @override
  State<PersonalName> createState() => _PersonalNameState();
}

class _PersonalNameState extends State<PersonalName> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Tên"),
      body: SafeArea(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
              color: const Color(0xffdadde2),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(221, 177, 177, 177),
                          spreadRadius: 1),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Tên',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          child: Divider(
                              color: Color.fromARGB(255, 126, 126, 126)),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            'Họ',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 40,
                          child: TextFormField(
                            controller: firstNameController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 15),
                          child: Text(
                            'Tên đệm',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 40,
                          child: TextFormField(
                            controller: middleNameController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 15),
                          child: Text(
                            'Tên',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 40,
                          child: TextFormField(
                            controller: lastNameController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(top: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: const Color(0xfff5f6f8),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(221, 177, 177, 177),
                                    spreadRadius: 1),
                              ],
                            ),
                            child: RichText(
                                text: const TextSpan(
                                    text: 'Xin lưu ý rằng: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        height: 1.5),
                                    children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        'Nếu đổi tên trên Facebook, bạn không thể đổi lại tên trong vòng 60 ngày. Đừng thêm bất cứ cách viết hoa khác thường, dấu câu, ký tự hoặc các từ ngẫu nhiên. ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  TextSpan(
                                    text: 'Tìm hiểu thêm.',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ]))),
                        const SizedBox(
                          height: 50,
                        ),
                        MyFilledButton(
                            isDisabled: false,
                            title: "Lưu thay đổi",
                            cbFunction: () {
                              if (firstNameController.text.isEmpty &&
                                  middleNameController.text.isEmpty &&
                                  lastNameController.text.isEmpty) {
                                showSnackBar(
                                    context: context,
                                    msg: "Vui lòng nhập thông tin!");
                              } else {
                                final regex = RegExp(r'\s+');
                                String fullName =
                                    '${firstNameController.text.trim()} ${middleNameController.text.trim()} ${lastNameController.text.trim()}'
                                        .trim()
                                        .replaceAll(regex, ' ');
                                debugPrint('check ${fullName}');
                                UserService().changeUsernameOrAvt(
                                  context: context,
                                  fullName: fullName,
                                );
                              }
                            },
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(240, 50)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                )))),
                      ],
                    ),
                  )))),
    );
  }
}
