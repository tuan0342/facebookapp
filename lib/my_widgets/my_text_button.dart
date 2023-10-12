import 'package:facebook_app/my_widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final bool isDisabled;
  final String title;
  final VoidCallback? cbFunction;

  MyTextButton({super.key, this.isDisabled = false, this.title = "", required this.cbFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: TextButton(
          onPressed: isDisabled ? null : () { cbFunction?.call(); },
          child: MyText(title: title, type: "buttonLabel",),
        ),
    );
  }
}