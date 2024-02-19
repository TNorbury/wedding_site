import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wedding_site/theme/theme.dart';

class RsvpPage extends StatelessWidget {
  const RsvpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "RSVP",
          style: textThemeOf(context).titleLarge,
        ),
      ],
    );
  }
}
