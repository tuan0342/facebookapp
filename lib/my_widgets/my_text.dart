import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String title;
  final String type;
  final TextStyle? style;

  const MyText(
      {super.key, required this.title, required this.type, this.style});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    TextStyle getTextStyle(String type) {
      switch (type) {
        case "title":
          return textTheme.headlineSmall!
              .merge(const TextStyle(fontWeight: FontWeight.bold));
        case "label":
          return textTheme.labelLarge!
              .merge(const TextStyle(color: Colors.black45));
        case "labelLarge":
          return textTheme.labelLarge!
              .merge(const TextStyle(fontWeight: FontWeight.bold));
        case "buttonLabel":
          return textTheme.labelLarge!.merge(const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.blueAccent));
        default:
          return textTheme.titleSmall!;
      }
    }

    return Text(title,
        style: style ?? getTextStyle(type),
        overflow: TextOverflow.clip,
        textAlign: TextAlign.center);
  }
}
