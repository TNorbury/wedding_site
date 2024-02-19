import 'package:flutter/material.dart';
import 'package:wedding_site/theme/theme.dart';

class VenuePage extends StatelessWidget {
  const VenuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Venue",
          style: textThemeOf(context).titleLarge,
        )
      ],
    );
  }
}
