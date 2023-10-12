import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyDatePicker extends StatelessWidget {
  const MyDatePicker({super.key, });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        child: SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime(2023, 2, 19),
            onDateTimeChanged: (DateTime newDateTime) {
            },
          ),
        ),
      ),
    );
  }
}