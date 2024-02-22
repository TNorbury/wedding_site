import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_site/common/widgets/input_field.dart';
import 'package:wedding_site/models/wedding_guest.dart';
import 'package:wedding_site/providers/wedding_guest_provider.dart';
import 'package:wedding_site/theme/breakpoints.dart';
import 'package:wedding_site/theme/theme.dart';

final rsvpProvider = StateProvider<bool?>((ref) {
  return null;
});

final bringingPlusOneProvider = StateProvider<bool>((ref) {
  return false;
});

final dietTcProvider = Provider.autoDispose<TextEditingController>((ref) {
  final tc = TextEditingController();

  ref.onDispose(() {
    tc.dispose();
  });

  return tc;
});

final guestNameTcProvider = Provider.autoDispose<TextEditingController>((ref) {
  final tc = TextEditingController();

  ref.onDispose(() {
    tc.dispose();
  });

  return tc;
});

final guestDietTcProvider = Provider.autoDispose<TextEditingController>((ref) {
  final tc = TextEditingController();

  ref.onDispose(() {
    tc.dispose();
  });

  return tc;
});

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
        final width = switch (c.maxWidth) {
          > WidthBreakpoints.large => c.maxWidth * .5,
          < WidthBreakpoints.large => c.maxWidth * .65,
          < WidthBreakpoints.medium => c.maxWidth * .7,
          < WidthBreakpoints.small => c.maxWidth * .75,
          _ => c.maxWidth - 64,
        };

        if (guest == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
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
              SizedBox(
                width: width,
                child: const GuestForm(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GuestForm extends ConsumerWidget {
  const GuestForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guest = ref.watch(weddingGuestProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              label: Text("RSVP"),
            ),
            value: ref.watch(rsvpProvider),
            items: const [
              DropdownMenuItem(
                value: true,
                child: Text("Yes"),
              ),
              DropdownMenuItem(
                value: false,
                child: Text("No"),
              ),
            ],
            onChanged: (val) {
              ref.read(rsvpProvider.notifier).state = val;
              ref
                  .read(weddingGuestProvider.notifier)
                  .setIsComing(ref.read(rsvpProvider)!);
            },
          ),
        ),
        if (ref.watch(rsvpProvider) == true) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: InputField(
              controller: ref.watch(dietTcProvider),
              label: "Dietary Restrictions",
              helperText: "Optional",
              maxLines: null,
              onChanged: () => ref
                  .read(weddingGuestProvider.notifier)
                  .setDietaryRestrictions(ref.read(dietTcProvider).text),
            ),
          ),
          if (guest!.plusOneAllowed) ...[
            const SizedBox(height: 16),
            const Divider(
              height: 24,
              indent: 4,
              endIndent: 4,
            ),
            const PlusOneForm(),
          ],
        ]
      ],
    );
  }
}

class PlusOneForm extends ConsumerWidget {
  const PlusOneForm({Key? key}) : super(key: key);

  void _submitPlusOneChanges(WidgetRef ref) {
    ref.read(weddingGuestProvider.notifier).setPlusOne(
          WeddingGuest(
            name: ref.read(guestNameTcProvider).text,
            dietaryInfo: ref.read(guestDietTcProvider).text,
          ),
        );
  }

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text("Bringing Plus-One"),
          value: ref.watch(bringingPlusOneProvider),
          onChanged: (val) =>
              ref.read(bringingPlusOneProvider.notifier).state = val,
        ),

        // if bring plus one, show fields for name and dietary restrictions
        if (ref.watch(bringingPlusOneProvider)) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: InputField(
              controller: ref.watch(guestNameTcProvider),
              label: "Plus One's Name",
              onChanged: () => _submitPlusOneChanges(ref),
            ),
          ),
          InputField(
            controller: ref.watch(guestDietTcProvider),
            label: "Plus One's Dietary Restrictions",
            helperText: "Optional",
            maxLines: null,
            onChanged: () => _submitPlusOneChanges(ref),
          ),
        ]
      ],
    );
  }
}
