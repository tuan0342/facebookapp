import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/user_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Coins extends StatefulWidget {
  const Coins({super.key});

  @override
  State<Coins> createState() => _CoinsState();
}

class _CoinsState extends State<Coins> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController coinsController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    final AppService _appService = Provider.of<AppService>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Quản lý coins"),
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
                boxShadow: const [BoxShadow(color: Color.fromARGB(221, 177, 177, 177),spreadRadius: 1),],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Số coins hiện tại:  ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                        Selector<AppService, String>(
                            selector: (_, notifier) =>
                                notifier.coins.toString(),
                            builder: (_, value, __) => Text(_appService.coins.toString(), 
                              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.blue))),
                        // Text(_appService.coins.toString(), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.blue)),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Divider(color: Color.fromARGB(255, 126, 126, 126)),
                    ),
                    const Text('Nạp coins:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5, top: 20),
                      child: Text('Nhập số coins muốn nạp:', style:TextStyle(fontSize: 16, color: Colors.black87),),
                    ),
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: TextFormField(
                        controller: coinsController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return 'Vui lòng nhập số coins muốn nạp!';
                          }
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
                            BoxShadow(color: Color.fromARGB(221, 177, 177, 177), spreadRadius: 1),
                          ],
                        ),
                        child: RichText(
                          text: const TextSpan(
                            text: 'Xin lưu ý rằng: ',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14,height: 1.5),
                            children: <TextSpan>[
                            TextSpan(
                              text: 'Mọi guest đăng nhập lần đầu sẽ được cấp 10 coins, guest phải nạp tiền thì mới thành user. Cho phép user (guest đặc biệt) đăng bài mới với một chế độ duy nhất là public, số lượng bài bị giới hạn trong số coins ',
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal),
                            ),
                            TextSpan(
                              text: '(Đăng 1 bài mất 4 coins). ',
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                            ),
                          ]
                        )
                      )
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    MyFilledButton(
                        isDisabled: false,
                        title: "Nạp coins",
                        cbFunction: () {
                          if (coinsController.text.isEmpty) {
                            showSnackBar(
                                context: context,
                                msg: "Vui lòng nhập số coins muốn nạp");
                          } else {
                            buyCoins();
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
              )
            )
          )
        ),
    );
  }

  void buyCoins() async {
    await UserService().buyCoins(context: context, coins: coinsController.text);
  }
}