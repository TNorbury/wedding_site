import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_site/models/wedding_guest.dart';
import 'package:wedding_site/providers/wedding_guest_provider.dart';
import 'package:wedding_site/services/firestore_service_provider.dart';

final weddingGuestRepositoryProvider = Provider<WeddingGuestRepository>(
  (ref) => WeddingGuestRepository(
    fs: ref.watch(firestoreServiceProvider),
    currentAccessCode: ref.watch(currentAccessCodeProvider),
  ),
);

class WeddingGuestRepository {
  final FirebaseFirestore fs;

  final CollectionReference<WeddingGuest> guestRef;

  final String currentAccessCode;

  WeddingGuestRepository({required this.fs, this.currentAccessCode = ""})
      : guestRef = fs.collection("guests").withConverter<WeddingGuest>(
              fromFirestore: (snapshot, options) {
                final json = snapshot.data()!;

                if (json['id'] == null || json['id'] == "") {
                  json['id'] = snapshot.id;
                }

                return WeddingGuest.fromJson(json);
              },
              toFirestore: (guest, options) => guest.toJson(),
            );

  Future<bool> validAccessCode(String accessCode) async {
    // don't allow outside of debug builds
    if (!kDebugMode && accessCode == "testtest") {
      return false;
    }
    final f = await guestRef.where("accessCode", isEqualTo: accessCode).get();
    return f.size != 0;
  }

  Stream<WeddingGuest> streamCurrentGuest() {
    if (currentAccessCode.isEmpty) {
      return const Stream.empty();
    }

    return guestRef
        .where("accessCode", isEqualTo: currentAccessCode)
        .limit(1)
        .snapshots()
        .map((event) => event.docs.first.data());
  }

  Future<void> updateGuest(WeddingGuest guest) async {
    await guestRef.doc(guest.id).set(guest);
  }
}
