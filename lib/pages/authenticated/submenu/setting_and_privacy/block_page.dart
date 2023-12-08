import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class BlockPage extends StatefulWidget {
  const BlockPage({super.key});

  @override
  State<BlockPage> createState() => _BlockPageState();
}

class _BlockPageState extends State<BlockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Danh sách bạn bè bị chặn"),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          color: Colors.white,
          child: Text('Danh sách bạn bè bị chặn')
        )
      ),
    );
  }
}