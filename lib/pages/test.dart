import 'package:facebook_app/pages/authenticated/home_page.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(email: "email"),
    );
  }
}