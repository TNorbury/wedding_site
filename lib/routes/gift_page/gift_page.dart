import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wedding_site/theme/breakpoints.dart';
import 'package:wedding_site/theme/theme.dart';

class GiftPage extends StatelessWidget {
  const GiftPage({Key? key}) : super(key: key);

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
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          children: [
            Text(
              "Gifts",
              style: textThemeOf(context).titleLarge,
            ),
            const Text(
              """
As we gear up for this next chapter of our life, including possible travel plans, we’re focused on keeping things simple. Below, you'll find options for those wishing to celebrate with us, including:""",
            ),
            const SizedBox(height: 16),
            const _FundText(),
            const SizedBox(height: 4),
            const _DonationOptionText(),
            const SizedBox(height: 4),
            const _RegistryText(),
            const SizedBox(height: 24),
            const Text(
                "We appreciate your support as we navigate this exciting phase and look forward to the adventures ahead!")
          ],
        ),
      );
    });
  }
}

class _FundText extends StatelessWidget {
  const _FundText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final donationRecognizer = TapGestureRecognizer()
      ..onTap = () => launchUrl(Uri.parse(
          "https://paypal.me/tylernorb42?country.x=US&locale.x=en_US"));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("•"),
        const SizedBox(width: 4),
        Flexible(
          child: RichText(
            text: TextSpan(
              text: "Our travel fund / wedding fund. ",
              style: textThemeOf(context).bodyMedium,
              children: [
                TextSpan(
                  recognizer: donationRecognizer,
                  text: "Donate via PayPal.",
                  style: textThemeOf(context)
                      .bodyMedium
                      .withColor(colorSchemeOf(context).primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DonationOptionText extends StatelessWidget {
  const _DonationOptionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final donationRecognizer = TapGestureRecognizer()
      ..onTap =
          () => launchUrl(Uri.parse("https://donate.cityteam.org/for/ctorg"));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("•"),
        const SizedBox(width: 4),
        Flexible(
          child: RichText(
            text: TextSpan(
              text: "Donating to ",
              style: textThemeOf(context).bodyMedium,
              children: [
                TextSpan(
                  recognizer: donationRecognizer,
                  text: "CityTeam Portland",
                  style: textThemeOf(context)
                      .bodyMedium
                      .withColor(colorSchemeOf(context).primary),
                ),
                const TextSpan(
                    text: ", a local organization we’d like to support.")
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RegistryText extends StatelessWidget {
  const _RegistryText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final donationRecognizer = TapGestureRecognizer()
      ..onTap = () => launchUrl(Uri.parse(
          "https://www.myregistry.com/wedding-registry/tyler-norbury-and-missy-ledoux-portland-or/4200752"));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("•"),
        const SizedBox(width: 4),
        Flexible(
          child: RichText(
            text: TextSpan(
              text:
                  "A small selection of practical items that fit our lifestyle. ",
              style: textThemeOf(context).bodyMedium,
              children: [
                TextSpan(
                  recognizer: donationRecognizer,
                  text: "See our registry here.",
                  style: textThemeOf(context)
                      .bodyMedium
                      .withColor(colorSchemeOf(context).primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
