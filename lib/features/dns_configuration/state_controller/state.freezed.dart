// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$State {
  String get dnsAdress => throw _privateConstructorUsedError;
  List<DnsModel> get logs => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  bool get isNetwork => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StateCopyWith<State> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StateCopyWith<$Res> {
  factory $StateCopyWith(State value, $Res Function(State) then) =
      _$StateCopyWithImpl<$Res, State>;
  @useResult
  $Res call(
      {String dnsAdress,
      List<DnsModel> logs,
      bool loading,
      String error,
      bool isNetwork});
}

/// @nodoc
class _$StateCopyWithImpl<$Res, $Val extends State>
    implements $StateCopyWith<$Res> {
  _$StateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dnsAdress = null,
    Object? logs = null,
    Object? loading = null,
    Object? error = null,
    Object? isNetwork = null,
  }) {
    return _then(_value.copyWith(
      dnsAdress: null == dnsAdress
          ? _value.dnsAdress
          : dnsAdress // ignore: cast_nullable_to_non_nullable
              as String,
      logs: null == logs
          ? _value.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<DnsModel>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      isNetwork: null == isNetwork
          ? _value.isNetwork
          : isNetwork // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StateImplCopyWith<$Res> implements $StateCopyWith<$Res> {
  factory _$$StateImplCopyWith(
          _$StateImpl value, $Res Function(_$StateImpl) then) =
      __$$StateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String dnsAdress,
      List<DnsModel> logs,
      bool loading,
      String error,
      bool isNetwork});
}

/// @nodoc
class __$$StateImplCopyWithImpl<$Res>
    extends _$StateCopyWithImpl<$Res, _$StateImpl>
    implements _$$StateImplCopyWith<$Res> {
  __$$StateImplCopyWithImpl(
      _$StateImpl _value, $Res Function(_$StateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dnsAdress = null,
    Object? logs = null,
    Object? loading = null,
    Object? error = null,
    Object? isNetwork = null,
  }) {
    return _then(_$StateImpl(
      dnsAdress: null == dnsAdress
          ? _value.dnsAdress
          : dnsAdress // ignore: cast_nullable_to_non_nullable
              as String,
      logs: null == logs
          ? _value._logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<DnsModel>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      isNetwork: null == isNetwork
          ? _value.isNetwork
          : isNetwork // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$StateImpl extends _State {
  const _$StateImpl(
      {required this.dnsAdress,
      required final List<DnsModel> logs,
      required this.loading,
      required this.error,
      required this.isNetwork})
      : _logs = logs,
        super._();

  @override
  final String dnsAdress;
  final List<DnsModel> _logs;
  @override
  List<DnsModel> get logs {
    if (_logs is EqualUnmodifiableListView) return _logs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_logs);
  }

  @override
  final bool loading;
  @override
  final String error;
  @override
  final bool isNetwork;

  @override
  String toString() {
    return 'State(dnsAdress: $dnsAdress, logs: $logs, loading: $loading, error: $error, isNetwork: $isNetwork)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateImpl &&
            (identical(other.dnsAdress, dnsAdress) ||
                other.dnsAdress == dnsAdress) &&
            const DeepCollectionEquality().equals(other._logs, _logs) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isNetwork, isNetwork) ||
                other.isNetwork == isNetwork));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dnsAdress,
      const DeepCollectionEquality().hash(_logs), loading, error, isNetwork);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StateImplCopyWith<_$StateImpl> get copyWith =>
      __$$StateImplCopyWithImpl<_$StateImpl>(this, _$identity);
}

abstract class _State extends State {
  const factory _State(
      {required final String dnsAdress,
      required final List<DnsModel> logs,
      required final bool loading,
      required final String error,
      required final bool isNetwork}) = _$StateImpl;
  const _State._() : super._();

  @override
  String get dnsAdress;
  @override
  List<DnsModel> get logs;
  @override
  bool get loading;
  @override
  String get error;
  @override
  bool get isNetwork;
  @override
  @JsonKey(ignore: true)
  _$$StateImplCopyWith<_$StateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
