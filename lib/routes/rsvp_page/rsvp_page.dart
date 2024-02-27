import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_site/models/wedding_guest.dart';
import 'package:wedding_site/providers/wedding_guest_provider.dart';
import 'package:wedding_site/routes/rsvp_page/guest_form.dart';
import 'package:wedding_site/theme/breakpoints.dart';
import 'package:wedding_site/theme/theme.dart';

class RsvpPage extends ConsumerStatefulWidget {
  const RsvpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RsvpPageState();
}

class _RsvpPageState extends ConsumerState<RsvpPage> {
  bool _initialLoad = false;
  ProviderSubscription<WeddingGuest?>? sub;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        sub = ref.listenManual(
          weddingGuestProvider,
          (previous, guest) {
            if (guest != null && !_initialLoad) {
              ref.read(rsvpProvider.notifier).state = guest.isComing;
              ref.read(dietTcProvider).text = guest.dietaryInfo;

              if (guest.plusOneAllowed) {
                ref.read(bringingPlusOneProvider.notifier).state =
                    guest.plusOne != null;

                ref.read(guestNameTcProvider).text = guest.plusOne?.name ?? "";
                ref.read(guestDietTcProvider).text =
                    guest.plusOne?.dietaryInfo ?? "";
              }

              _initialLoad = true;
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    sub?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(dietTcProvider);
    ref.watch(guestNameTcProvider);
    ref.watch(guestDietTcProvider);
    final guest = ref.watch(weddingGuestProvider);
    return LayoutBuilder(
      builder: (context, c) {
        final padding = switch (c.maxWidth) {
          < WidthBreakpoints.small => 32.0,
          < WidthBreakpoints.medium => 32.0,
          < WidthBreakpoints.large => 128.0,
          > WidthBreakpoints.large => 256.0,
          _ => 32.0,
        };

        if (guest == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            children: [
              Text(
                "RSVP",
                style: textThemeOf(context).titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                "We hope to see you ${guest.name}. Please let us know if you're coming and enter any dietary restrictions that you have.",
              ),
              const GuestForm(),
            ],
          ),
        );
      },
    );
  }
}
