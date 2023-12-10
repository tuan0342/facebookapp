import 'package:facebook_app/my_widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final bool isDisabled;
  final String title;
  final TextStyle? textStyle;
  final ButtonStyle? style;
  final VoidCallback? cbFunction;

  const MyTextButton(
      {super.key,
      this.isDisabled = false,
      this.title = "",
      this.textStyle,
      this.style,
      required this.cbFunction});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isDisabled
          ? null
          : () {
              cbFunction?.call();
            },
      style: style ??
          TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
      child: MyText(
        title: title,
        type: "buttonLabel",
        style: textStyle ?? const TextStyle(),
      ),
    );
  }
}
