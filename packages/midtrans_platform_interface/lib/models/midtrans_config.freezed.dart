// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'midtrans_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MidtransConfig _$MidtransConfigFromJson(Map<String, dynamic> json) {
  return _MidtransConfig.fromJson(json);
}

/// @nodoc
mixin _$MidtransConfig {
  String get clientKey => throw _privateConstructorUsedError;
  String get baseUrl => throw _privateConstructorUsedError;
  bool get enableLog => throw _privateConstructorUsedError;
  bool get isProduction => throw _privateConstructorUsedError;

  /// Serializes this MidtransConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MidtransConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MidtransConfigCopyWith<MidtransConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MidtransConfigCopyWith<$Res> {
  factory $MidtransConfigCopyWith(
          MidtransConfig value, $Res Function(MidtransConfig) then) =
      _$MidtransConfigCopyWithImpl<$Res, MidtransConfig>;
  @useResult
  $Res call(
      {String clientKey, String baseUrl, bool enableLog, bool isProduction});
}

/// @nodoc
class _$MidtransConfigCopyWithImpl<$Res, $Val extends MidtransConfig>
    implements $MidtransConfigCopyWith<$Res> {
  _$MidtransConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MidtransConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientKey = null,
    Object? baseUrl = null,
    Object? enableLog = null,
    Object? isProduction = null,
  }) {
    return _then(_value.copyWith(
      clientKey: null == clientKey
          ? _value.clientKey
          : clientKey // ignore: cast_nullable_to_non_nullable
              as String,
      baseUrl: null == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      enableLog: null == enableLog
          ? _value.enableLog
          : enableLog // ignore: cast_nullable_to_non_nullable
              as bool,
      isProduction: null == isProduction
          ? _value.isProduction
          : isProduction // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MidtransConfigImplCopyWith<$Res>
    implements $MidtransConfigCopyWith<$Res> {
  factory _$$MidtransConfigImplCopyWith(_$MidtransConfigImpl value,
          $Res Function(_$MidtransConfigImpl) then) =
      __$$MidtransConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clientKey, String baseUrl, bool enableLog, bool isProduction});
}

/// @nodoc
class __$$MidtransConfigImplCopyWithImpl<$Res>
    extends _$MidtransConfigCopyWithImpl<$Res, _$MidtransConfigImpl>
    implements _$$MidtransConfigImplCopyWith<$Res> {
  __$$MidtransConfigImplCopyWithImpl(
      _$MidtransConfigImpl _value, $Res Function(_$MidtransConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of MidtransConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientKey = null,
    Object? baseUrl = null,
    Object? enableLog = null,
    Object? isProduction = null,
  }) {
    return _then(_$MidtransConfigImpl(
      clientKey: null == clientKey
          ? _value.clientKey
          : clientKey // ignore: cast_nullable_to_non_nullable
              as String,
      baseUrl: null == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      enableLog: null == enableLog
          ? _value.enableLog
          : enableLog // ignore: cast_nullable_to_non_nullable
              as bool,
      isProduction: null == isProduction
          ? _value.isProduction
          : isProduction // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MidtransConfigImpl implements _MidtransConfig {
  const _$MidtransConfigImpl(
      {required this.clientKey,
      required this.baseUrl,
      this.enableLog = false,
      this.isProduction = false});

  factory _$MidtransConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MidtransConfigImplFromJson(json);

  @override
  final String clientKey;
  @override
  final String baseUrl;
  @override
  @JsonKey()
  final bool enableLog;
  @override
  @JsonKey()
  final bool isProduction;

  @override
  String toString() {
    return 'MidtransConfig(clientKey: $clientKey, baseUrl: $baseUrl, enableLog: $enableLog, isProduction: $isProduction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MidtransConfigImpl &&
            (identical(other.clientKey, clientKey) ||
                other.clientKey == clientKey) &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.enableLog, enableLog) ||
                other.enableLog == enableLog) &&
            (identical(other.isProduction, isProduction) ||
                other.isProduction == isProduction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, clientKey, baseUrl, enableLog, isProduction);

  /// Create a copy of MidtransConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MidtransConfigImplCopyWith<_$MidtransConfigImpl> get copyWith =>
      __$$MidtransConfigImplCopyWithImpl<_$MidtransConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MidtransConfigImplToJson(
      this,
    );
  }
}

abstract class _MidtransConfig implements MidtransConfig {
  const factory _MidtransConfig(
      {required final String clientKey,
      required final String baseUrl,
      final bool enableLog,
      final bool isProduction}) = _$MidtransConfigImpl;

  factory _MidtransConfig.fromJson(Map<String, dynamic> json) =
      _$MidtransConfigImpl.fromJson;

  @override
  String get clientKey;
  @override
  String get baseUrl;
  @override
  bool get enableLog;
  @override
  bool get isProduction;

  /// Create a copy of MidtransConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MidtransConfigImplCopyWith<_$MidtransConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
