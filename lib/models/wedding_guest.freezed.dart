// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wedding_guest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeddingGuest _$WeddingGuestFromJson(Map<String, dynamic> json) {
  return _WeddingGuest.fromJson(json);
}

/// @nodoc
mixin _$WeddingGuest {
// firestore ID
  String get id =>
      throw _privateConstructorUsedError; // randomly generated access code, allows guests to access the site
  String get accessCode => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool? get isComing => throw _privateConstructorUsedError;
  String get dietaryInfo => throw _privateConstructorUsedError;
  bool get plusOneAllowed => throw _privateConstructorUsedError;
  WeddingGuest? get plusOne => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeddingGuestCopyWith<WeddingGuest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeddingGuestCopyWith<$Res> {
  factory $WeddingGuestCopyWith(
          WeddingGuest value, $Res Function(WeddingGuest) then) =
      _$WeddingGuestCopyWithImpl<$Res, WeddingGuest>;
  @useResult
  $Res call(
      {String id,
      String accessCode,
      String name,
      bool? isComing,
      String dietaryInfo,
      bool plusOneAllowed,
      WeddingGuest? plusOne});

  $WeddingGuestCopyWith<$Res>? get plusOne;
}

/// @nodoc
class _$WeddingGuestCopyWithImpl<$Res, $Val extends WeddingGuest>
    implements $WeddingGuestCopyWith<$Res> {
  _$WeddingGuestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accessCode = null,
    Object? name = null,
    Object? isComing = freezed,
    Object? dietaryInfo = null,
    Object? plusOneAllowed = null,
    Object? plusOne = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      accessCode: null == accessCode
          ? _value.accessCode
          : accessCode // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isComing: freezed == isComing
          ? _value.isComing
          : isComing // ignore: cast_nullable_to_non_nullable
              as bool?,
      dietaryInfo: null == dietaryInfo
          ? _value.dietaryInfo
          : dietaryInfo // ignore: cast_nullable_to_non_nullable
              as String,
      plusOneAllowed: null == plusOneAllowed
          ? _value.plusOneAllowed
          : plusOneAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
      plusOne: freezed == plusOne
          ? _value.plusOne
          : plusOne // ignore: cast_nullable_to_non_nullable
              as WeddingGuest?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WeddingGuestCopyWith<$Res>? get plusOne {
    if (_value.plusOne == null) {
      return null;
    }

    return $WeddingGuestCopyWith<$Res>(_value.plusOne!, (value) {
      return _then(_value.copyWith(plusOne: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WeddingGuestImplCopyWith<$Res>
    implements $WeddingGuestCopyWith<$Res> {
  factory _$$WeddingGuestImplCopyWith(
          _$WeddingGuestImpl value, $Res Function(_$WeddingGuestImpl) then) =
      __$$WeddingGuestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String accessCode,
      String name,
      bool? isComing,
      String dietaryInfo,
      bool plusOneAllowed,
      WeddingGuest? plusOne});

  @override
  $WeddingGuestCopyWith<$Res>? get plusOne;
}

/// @nodoc
class __$$WeddingGuestImplCopyWithImpl<$Res>
    extends _$WeddingGuestCopyWithImpl<$Res, _$WeddingGuestImpl>
    implements _$$WeddingGuestImplCopyWith<$Res> {
  __$$WeddingGuestImplCopyWithImpl(
      _$WeddingGuestImpl _value, $Res Function(_$WeddingGuestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accessCode = null,
    Object? name = null,
    Object? isComing = freezed,
    Object? dietaryInfo = null,
    Object? plusOneAllowed = null,
    Object? plusOne = freezed,
  }) {
    return _then(_$WeddingGuestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      accessCode: null == accessCode
          ? _value.accessCode
          : accessCode // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isComing: freezed == isComing
          ? _value.isComing
          : isComing // ignore: cast_nullable_to_non_nullable
              as bool?,
      dietaryInfo: null == dietaryInfo
          ? _value.dietaryInfo
          : dietaryInfo // ignore: cast_nullable_to_non_nullable
              as String,
      plusOneAllowed: null == plusOneAllowed
          ? _value.plusOneAllowed
          : plusOneAllowed // ignore: cast_nullable_to_non_nullable
              as bool,
      plusOne: freezed == plusOne
          ? _value.plusOne
          : plusOne // ignore: cast_nullable_to_non_nullable
              as WeddingGuest?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeddingGuestImpl implements _WeddingGuest {
  const _$WeddingGuestImpl(
      {required this.id,
      required this.accessCode,
      required this.name,
      this.isComing,
      this.dietaryInfo = "",
      this.plusOneAllowed = false,
      this.plusOne});

  factory _$WeddingGuestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeddingGuestImplFromJson(json);

// firestore ID
  @override
  final String id;
// randomly generated access code, allows guests to access the site
  @override
  final String accessCode;
  @override
  final String name;
  @override
  final bool? isComing;
  @override
  @JsonKey()
  final String dietaryInfo;
  @override
  @JsonKey()
  final bool plusOneAllowed;
  @override
  final WeddingGuest? plusOne;

  @override
  String toString() {
    return 'WeddingGuest(id: $id, accessCode: $accessCode, name: $name, isComing: $isComing, dietaryInfo: $dietaryInfo, plusOneAllowed: $plusOneAllowed, plusOne: $plusOne)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeddingGuestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accessCode, accessCode) ||
                other.accessCode == accessCode) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isComing, isComing) ||
                other.isComing == isComing) &&
            (identical(other.dietaryInfo, dietaryInfo) ||
                other.dietaryInfo == dietaryInfo) &&
            (identical(other.plusOneAllowed, plusOneAllowed) ||
                other.plusOneAllowed == plusOneAllowed) &&
            (identical(other.plusOne, plusOne) || other.plusOne == plusOne));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, accessCode, name, isComing,
      dietaryInfo, plusOneAllowed, plusOne);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeddingGuestImplCopyWith<_$WeddingGuestImpl> get copyWith =>
      __$$WeddingGuestImplCopyWithImpl<_$WeddingGuestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeddingGuestImplToJson(
      this,
    );
  }
}

abstract class _WeddingGuest implements WeddingGuest {
  const factory _WeddingGuest(
      {required final String id,
      required final String accessCode,
      required final String name,
      final bool? isComing,
      final String dietaryInfo,
      final bool plusOneAllowed,
      final WeddingGuest? plusOne}) = _$WeddingGuestImpl;

  factory _WeddingGuest.fromJson(Map<String, dynamic> json) =
      _$WeddingGuestImpl.fromJson;

  @override // firestore ID
  String get id;
  @override // randomly generated access code, allows guests to access the site
  String get accessCode;
  @override
  String get name;
  @override
  bool? get isComing;
  @override
  String get dietaryInfo;
  @override
  bool get plusOneAllowed;
  @override
  WeddingGuest? get plusOne;
  @override
  @JsonKey(ignore: true)
  _$$WeddingGuestImplCopyWith<_$WeddingGuestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
