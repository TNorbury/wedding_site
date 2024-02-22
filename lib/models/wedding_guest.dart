import 'package:freezed_annotation/freezed_annotation.dart';

part 'wedding_guest.freezed.dart';
part 'wedding_guest.g.dart';

@freezed
class WeddingGuest with _$WeddingGuest {
  const factory WeddingGuest({
    // firestore ID
    String? id,

    // randomly generated access code, allows guests to access the site
    String? accessCode,
    required String name,
    bool? isComing,
    @Default("") String dietaryInfo,
    @Default(false) bool plusOneAllowed,
    WeddingGuest? plusOne,
  }) = _WeddingGuest;

  factory WeddingGuest.fromJson(Map<String, dynamic> json) =>
      _$WeddingGuestFromJson(json);
}
