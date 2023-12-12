import 'package:flutter/material.dart';

class MyEditText extends StatelessWidget {
  final bool isDisabled;
  final String labelText;
  final String? hintText;
  final String? errorText;

  const MyEditText({
    super.key,
    required this.isDisabled,
    required this.labelText,
    this.hintText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        child: TextFormField(
          cursorColor: Colors.lightBlue,
          style: const TextStyle(color: Colors.black38),
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: labelText,
          ),
        ),
      ),
    );
  }
}
