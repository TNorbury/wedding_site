import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstorage/localstorage.dart';

final _storage = LocalStorage("accessKey");

const kAccessCodeKey = "accessCode";

final localStorageProvider = FutureProvider<LocalStorage>((ref) async {
  await _storage.ready;
  return _storage;
});

final localStorageValueProvider =
    FutureProvider.family.autoDispose<dynamic, String>((ref, key) async {
  await _storage.ready;
  return _storage.getItem(key);
});
