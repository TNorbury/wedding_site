import 'package:flutter/widgets.dart';
import 'package:wedding_site/theme/theme.dart';

class InfoSection extends StatelessWidget {
  final String label;
  final String? body;
  final TextSpan? text;
  const InfoSection({
    Key? key,
    required this.label,
    this.body,
    this.text,
  })  : assert(
            (body != null && text == null) || (body == null && text != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textThemeOf(context).titleLarge,
          ),
          if (body != null)
            Text(body!)
          else if (text != null)
            RichText(
              text: TextSpan(
                children: [text!],
                style: textThemeOf(context).bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}
