import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: TextButton(onPressed: () {
      },child: const Text("Waiting ...", style: TextStyle(
        color: Colors.grey,
        fontSize: 30
      ),),),)),
    );
  }
}