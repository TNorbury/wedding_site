import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_site/common/widgets/info_section.dart';
import 'package:wedding_site/models/wedding_guest.dart';
import 'package:wedding_site/providers/wedding_guest_provider.dart';
import 'package:wedding_site/routes/router.dart';
import 'package:wedding_site/theme/breakpoints.dart';
import 'package:wedding_site/theme/theme.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final WeddingGuest(
      :name,
      :plusOne,
    ) = ref.watch(weddingGuestProvider) ?? const WeddingGuest(name: "");

    StringBuffer sb = StringBuffer(name);

    if (plusOne != null && plusOne.name.isNotEmpty) {
      sb.write(" & ${plusOne.name}");
    }

    final salutations = sb.toString();

    return LayoutBuilder(builder: (context, c) {
      final padding = switch (c.maxWidth) {
        < WidthBreakpoints.small => 32.0,
        < WidthBreakpoints.medium => 32.0,
        < WidthBreakpoints.large => 128.0,
        < WidthBreakpoints.xLarge - 320 => 256.0,
        < WidthBreakpoints.xLarge => 512.0,
        > WidthBreakpoints.xLarge => 512.0,
        _ => 32.0,
      };

      final venueInfoTapRecognizer = TapGestureRecognizer()
        ..onTap = () => VenueRouteData().go(context);

      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              """
Welcome, $salutations, to the behitchment of Missy and Tyler. We’re excited to celebrate with you! 
    
Here’s some general information about the event.
          """,
              style: textThemeOf(context).bodyMedium,
            ),
            const InfoSection(
              label: "When",
              body: """
Friday night, May 31st
5:30 PM to 9:30 PM""",
            ),
            InfoSection(
              label: "Where",
              text: TextSpan(
                children: [
                  const TextSpan(text: "Opal 28. See "),
                  TextSpan(
                    text: "Venue Info",
                    style:
                        textThemeOf(context).bodyMedium.withColor(Colors.blue),
                    recognizer: venueInfoTapRecognizer,
                  ),
                  const TextSpan(text: " page for more information."),
                ],
              ),
            ),
            const InfoSection(
              label: "What to wear",
              body:
                  "Whatever you feel comfortable and cool in – if in doubt, go with smart casual. Creativity and expression are welcome.",
            ),
            const InfoSection(
              label: "Food and Drink",
              body:
                  "We will provide dinner and drinks (beer & wine) for all attendees!",
            )
          ],
        ),
      );
    });
  }
}
