import 'package:flutter/material.dart';

class MyFilledButton extends StatelessWidget {
  final bool isDisabled;
  final String title;
  final TextStyle? textStyle;
  final VoidCallback? cbFunction;
  final ButtonStyle? style;

  MyFilledButton(
      {super.key,
      required this.isDisabled,
      this.title = "",
      this.textStyle,
      required this.cbFunction,
      this.style});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      // If the button size(Row) is 90% then we give margin 5% + 5% like this
      margin: EdgeInsets.symmetric(horizontal: 0.08 * deviceWidth),
      // We need a Row in order to "Expanded" to work
      child: Row(
        children: <Widget>[
          Expanded(
            child: FilledButton(
              style: style ??
                  ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))),
              onPressed: isDisabled
                  ? null
                  : () {
                      cbFunction?.call();
                    },
              child: Text(
                title,
                style: textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
