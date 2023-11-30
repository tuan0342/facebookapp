import 'package:flutter/material.dart';

class ErrorGettingDataScreen extends StatelessWidget {
  const ErrorGettingDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Center(
      child: Text(
        "Có lỗi xảy ra, vui lòng thử lại sau",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ));
  }
}
