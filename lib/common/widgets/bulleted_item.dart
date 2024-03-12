import 'package:flutter/material.dart';

class BulletedItem extends StatelessWidget {
  final String text;
  const BulletedItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("•"),
        const SizedBox(width: 4),
        Flexible(child: Text(text)),
      ],
    );
  }
}
