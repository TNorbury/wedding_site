// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wedding_guest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeddingGuestImpl _$$WeddingGuestImplFromJson(Map<String, dynamic> json) =>
    _$WeddingGuestImpl(
      id: json['id'] as String,
      accessCode: json['accessCode'] as String,
      name: json['name'] as String,
      isComing: json['isComing'] as bool?,
      dietaryInfo: json['dietaryInfo'] as String? ?? "",
      plusOneAllowed: json['plusOneAllowed'] as bool? ?? false,
      plusOne: json['plusOne'] == null
          ? null
          : WeddingGuest.fromJson(json['plusOne'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WeddingGuestImplToJson(_$WeddingGuestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accessCode': instance.accessCode,
      'name': instance.name,
      'isComing': instance.isComing,
      'dietaryInfo': instance.dietaryInfo,
      'plusOneAllowed': instance.plusOneAllowed,
      'plusOne': instance.plusOne,
    };
