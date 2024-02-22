import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_site/models/wedding_guest.dart';
import 'package:wedding_site/services/repositories/wedding_guest_repository.dart';

enum SetStatus {
  waiting,
  done,
}

final setStatusProvider = StateProvider<SetStatus?>((ref) {
  return null;
});

final weddingGuestProvider =
    StateNotifierProvider.autoDispose<WeddingGuestNotifier, WeddingGuest?>(
        (ref) {
  final weddingGuestNotifier = WeddingGuestNotifier(ref);
  final sub =
      ref.watch(weddingGuestRepositoryProvider).streamCurrentGuest().listen(
    (guest) {
      weddingGuestNotifier.setGuest(guest);
    },
  );

  ref.onDispose(() {
    sub.cancel();
    weddingGuestNotifier._updateStateDebounceTimer?.cancel();
  });

  return weddingGuestNotifier;
});

class WeddingGuestNotifier extends StateNotifier<WeddingGuest?> {
  final Ref ref;
  WeddingGuestNotifier(this.ref) : super(null);

  Timer? _updateStateDebounceTimer;

  void setGuest(WeddingGuest guest) {
    state = guest;
  }

  void setIsComing(bool isComing) {
    assert(state != null);
    state = state!.copyWith(isComing: isComing);
    _scheduleSetUpdate();
  }

  void setDietaryRestrictions(String restrictions) {
    assert(state != null);
    state = state!.copyWith(dietaryInfo: restrictions);
    _scheduleSetUpdate();
  }

  void setPlusOne(WeddingGuest plusOne) {
    assert(state != null);
    state = state!.copyWith(plusOne: plusOne);
    _scheduleSetUpdate();
  }

  void _scheduleSetUpdate() {
    _updateStateDebounceTimer?.cancel();
    ref.read(setStatusProvider.notifier).state = SetStatus.waiting;
    _updateStateDebounceTimer = Timer(
      const Duration(seconds: 3),
      () async {
        await ref.read(weddingGuestRepositoryProvider).updateGuest(state!);
        ref.read(setStatusProvider.notifier).state = SetStatus.done;
      },
    );
  }
}
