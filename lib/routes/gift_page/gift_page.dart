import 'package:flutter/widgets.dart';
import 'package:wedding_site/theme/theme.dart';

class GiftPage extends StatelessWidget {
  const GiftPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Gifts",
          style: textThemeOf(context).titleLarge,
        ),
      ],
    );
  }
}
