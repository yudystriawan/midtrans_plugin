import 'package:freezed_annotation/freezed_annotation.dart';

part 'midtrans_config.freezed.dart';
part 'midtrans_config.g.dart';

@freezed
class MidtransConfig with _$MidtransConfig {
  const factory MidtransConfig({
    required String clientKey,
    required String baseUrl,
    @Default(false) bool enableLog,
    @Default(false) bool isProduction,
  }) = _MidtransConfig;

  factory MidtransConfig.fromJson(Map<String, dynamic> json) =>
      _$MidtransConfigFromJson(json);
}
