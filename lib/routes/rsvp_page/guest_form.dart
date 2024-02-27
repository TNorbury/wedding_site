import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_site/common/widgets/input_field.dart';
import 'package:wedding_site/models/wedding_guest.dart';
import 'package:wedding_site/providers/wedding_guest_provider.dart';

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
    if (ref.read(bringingPlusOneProvider)) {
    ref.read(weddingGuestProvider.notifier).setPlusOne(
          WeddingGuest(
            name: ref.read(guestNameTcProvider).text,
            dietaryInfo: ref.read(guestDietTcProvider).text,
          ),
        );
    } else {
      ref.read(weddingGuestProvider.notifier).setPlusOne(null);
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text("Bringing Plus-One"),
          value: ref.watch(bringingPlusOneProvider),
          onChanged: (val) {
            ref.read(bringingPlusOneProvider.notifier).state = val;

            _submitPlusOneChanges(ref);
          },
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
