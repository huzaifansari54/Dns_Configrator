// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DnsModel {
  String get dsaAddress => throw _privateConstructorUsedError;
  String get timesTamps => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DnsModelCopyWith<DnsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DnsModelCopyWith<$Res> {
  factory $DnsModelCopyWith(DnsModel value, $Res Function(DnsModel) then) =
      _$DnsModelCopyWithImpl<$Res, DnsModel>;
  @useResult
  $Res call({String dsaAddress, String timesTamps, bool isActive});
}

/// @nodoc
class _$DnsModelCopyWithImpl<$Res, $Val extends DnsModel>
    implements $DnsModelCopyWith<$Res> {
  _$DnsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dsaAddress = null,
    Object? timesTamps = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      dsaAddress: null == dsaAddress
          ? _value.dsaAddress
          : dsaAddress // ignore: cast_nullable_to_non_nullable
              as String,
      timesTamps: null == timesTamps
          ? _value.timesTamps
          : timesTamps // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DnsModelImplCopyWith<$Res>
    implements $DnsModelCopyWith<$Res> {
  factory _$$DnsModelImplCopyWith(
          _$DnsModelImpl value, $Res Function(_$DnsModelImpl) then) =
      __$$DnsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String dsaAddress, String timesTamps, bool isActive});
}

/// @nodoc
class __$$DnsModelImplCopyWithImpl<$Res>
    extends _$DnsModelCopyWithImpl<$Res, _$DnsModelImpl>
    implements _$$DnsModelImplCopyWith<$Res> {
  __$$DnsModelImplCopyWithImpl(
      _$DnsModelImpl _value, $Res Function(_$DnsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dsaAddress = null,
    Object? timesTamps = null,
    Object? isActive = null,
  }) {
    return _then(_$DnsModelImpl(
      dsaAddress: null == dsaAddress
          ? _value.dsaAddress
          : dsaAddress // ignore: cast_nullable_to_non_nullable
              as String,
      timesTamps: null == timesTamps
          ? _value.timesTamps
          : timesTamps // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DnsModelImpl extends _DnsModel {
  const _$DnsModelImpl(
      {required this.dsaAddress,
      required this.timesTamps,
      required this.isActive})
      : super._();

  @override
  final String dsaAddress;
  @override
  final String timesTamps;
  @override
  final bool isActive;

  @override
  String toString() {
    return 'DnsModel(dsaAddress: $dsaAddress, timesTamps: $timesTamps, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DnsModelImpl &&
            (identical(other.dsaAddress, dsaAddress) ||
                other.dsaAddress == dsaAddress) &&
            (identical(other.timesTamps, timesTamps) ||
                other.timesTamps == timesTamps) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, dsaAddress, timesTamps, isActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DnsModelImplCopyWith<_$DnsModelImpl> get copyWith =>
      __$$DnsModelImplCopyWithImpl<_$DnsModelImpl>(this, _$identity);
}

abstract class _DnsModel extends DnsModel {
  const factory _DnsModel(
      {required final String dsaAddress,
      required final String timesTamps,
      required final bool isActive}) = _$DnsModelImpl;
  const _DnsModel._() : super._();

  @override
  String get dsaAddress;
  @override
  String get timesTamps;
  @override
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$$DnsModelImplCopyWith<_$DnsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
