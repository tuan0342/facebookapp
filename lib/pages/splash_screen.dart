import 'package:facebook_app/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AppService _appService;

  @override
  void initState() {
    super.initState();
    _appService = Provider.of<AppService>(context, listen: false);
    onStartUp();
  }

  void onStartUp() async {
    await _appService.onAppStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        const SizedBox(
          height: 150,
        ),
        Image.asset(
          "assets/images/af_logo.png",
          height: 200,
          width: 200,
        ),
        const CircularProgressIndicator()
      ])),
    );
  }
}
