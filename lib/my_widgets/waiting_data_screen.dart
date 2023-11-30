import 'package:flutter/material.dart';

class WaitingDataScreen extends StatelessWidget {
  const WaitingDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
