import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wedding_site/common/widgets/bulleted_item.dart';
import 'package:wedding_site/common/widgets/info_section.dart';
import 'package:wedding_site/theme/breakpoints.dart';
import 'package:wedding_site/theme/theme.dart';

class VenuePage extends StatelessWidget {
  const VenuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      final locationWebsiteRecognizer = TapGestureRecognizer()
        ..onTap = () {
          const url = "http://www.opal28.com/";

          launchUrl(Uri.parse(url));
        };

      final gMapsRecognizer = TapGestureRecognizer()
        ..onTap = () {
          const url = "https://maps.app.goo.gl/r7k3H79tujNjxiv86";

          launchUrl(Uri.parse(url));
        };
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoSection(
              label: "Location",
              text: TextSpan(
                text: "Opal 28",
                recognizer: locationWebsiteRecognizer,
                style: textThemeOf(context)
                    .bodyMedium
                    .withColor(colorSchemeOf(context).primary),
              ),
            ),
            InfoSection(
              label: "Address",
              text: TextSpan(
                text: "510 NE 28th Ave, Portland, OR 97232",
                recognizer: gMapsRecognizer,
                style: textThemeOf(context)
                    .bodyMedium
                    .withColor(colorSchemeOf(context).primary),
              ),
            ),
            const InfoSection(
              label: "Is it Indoors or Outdoors?",
              body:
                  "Both! Opal 28 is a vintage property with an outdoor patio and indoor space.\nIf the weather’s bad, we’ll stay inside.",
            ),
            const _GettingThereInfo()
          ],
        ),
      );
    });
  }
}

class _GettingThereInfo extends StatelessWidget {
  const _GettingThereInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Getting There",
            style: textThemeOf(context).titleLarge,
          ),
          const _BulletedBusInfo(),
          const SizedBox(
            height: 8,
          ),
          const BulletedItem(
            text:
                "Biking: Bring your bikes right on into our venue, they’ll make great decor!",
          ),
          const SizedBox(
            height: 8,
          ),
          const BulletedItem(
            text:
                "Driving: Street parking is available in the surrounding neighborhood.",
          )
        ],
      ),
    );
  }
}

class _BulletedBusInfo extends StatelessWidget {
  const _BulletedBusInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final busRecognizer = TapGestureRecognizer()
      ..onTap = () {
        const url = "https://trimet.org/howtoride/bus.htm";

        launchUrl(Uri.parse(url));
      };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("•"),
        Flexible(
          child: RichText(
            text: TextSpan(
              style: textThemeOf(context).bodyMedium,
              children: [
                const TextSpan(
                  text:
                      "Transit: Want to make Tyler & Missy’s day? Take public transit to our wedding! Opal 28 is near the 12, 19, and 20 bus lines. Explore your options",
                ),
                TextSpan(
                  text: " here",
                  style: textThemeOf(context)
                      .bodyMedium
                      .withColor(colorSchemeOf(context).primary),
                  recognizer: busRecognizer,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
