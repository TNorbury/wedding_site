import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wedding_site/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "INFO",
          style: textThemeOf(context).titleLarge,
        ),
        Text(
          "You are invited to our behitchment ceremony",
          style: textThemeOf(context).bodyMedium,
        ),
      ],
    );
  }
}
