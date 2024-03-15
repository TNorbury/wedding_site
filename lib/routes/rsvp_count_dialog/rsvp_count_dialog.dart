import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wedding_site/models/wedding_guest.dart';
import 'package:wedding_site/services/repositories/wedding_guest_repository.dart';
import 'package:wedding_site/theme/theme.dart';

class RsvpCountDialog extends ConsumerStatefulWidget {
  const RsvpCountDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RsvpCountDialogState();
}

class _RsvpCountDialogState extends ConsumerState<RsvpCountDialog> {
  Future<List<List<WeddingGuest>>>? _weddingGuestsFuture;

  @override
  void initState() {
    super.initState();

    final guestRepo = ref.read(weddingGuestRepositoryProvider);

    final unconfirmedGuests = guestRepo.getAllGuests(isRsvp: null);
    final confirmedGuests = guestRepo.getAllGuests(isRsvp: true);
    final notComingGuests = guestRepo.getAllGuests(isRsvp: false);

    _weddingGuestsFuture =
        Future.wait([unconfirmedGuests, confirmedGuests, notComingGuests]);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: _weddingGuestsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final confirmedGuests = snapshot.data![1]
                    .where((element) => element.name != "Test Guy Ty");
                final notComingGuests = snapshot.data![2];
                final unconfirmedGuests = snapshot.data![0].where(
                  (element) =>
                      !confirmedGuests.contains(element) &&
                      !notComingGuests.contains(element) &&
                      element.name != "Test Guy Ty",
                );

                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Unconfirmed (${unconfirmedGuests.length})",
                              style: textThemeOf(context).titleMedium,
                            ),
                            for (final guest in unconfirmedGuests)
                              WeddingGuestTile(guest: guest)
                          ],
                        ),
                      ),
                      const VerticalDivider(),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Coming (${confirmedGuests.length})",
                              style: textThemeOf(context).titleMedium,
                            ),
                            for (final guest in confirmedGuests)
                              WeddingGuestTile(guest: guest)
                          ],
                        ),
                      ),
                      const VerticalDivider(),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Not Coming (${notComingGuests.length})",
                              style: textThemeOf(context).titleMedium,
                            ),
                            for (final guest in notComingGuests)
                              WeddingGuestTile(guest: guest)
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

class WeddingGuestTile extends StatelessWidget {
  final WeddingGuest guest;
  const WeddingGuestTile({
    Key? key,
    required this.guest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StringBuffer names = StringBuffer(guest.name);

    if (guest.plusOne != null) {
      names.write(" & ${guest.plusOne!.name}");
    }

    StringBuffer dietaryInfoSb = StringBuffer("");

    var plusOneHasDiet = guest.plusOne?.dietaryInfo.isNotEmpty ?? false;
    if (guest.dietaryInfo.isNotEmpty) {
      dietaryInfoSb.write(guest.dietaryInfo);

      if (plusOneHasDiet) {
        dietaryInfoSb.write(", ${guest.plusOne?.dietaryInfo}");
      }
    } else if (plusOneHasDiet) {
      dietaryInfoSb.write("${guest.plusOne?.dietaryInfo}");
    }

    String dietaryInfo = dietaryInfoSb.toString();

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            names.toString(),
            textAlign: TextAlign.start,
          ),
          if (dietaryInfo.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                dietaryInfo,
                style: textThemeOf(context).bodySmall,
              ),
            ),
        ],
      ),
    );
  }
}
