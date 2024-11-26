import 'package:freezed_annotation/freezed_annotation.dart';

part 'midtrans_failure.freezed.dart';

@freezed
class MidtransFailure with _$MidtransFailure {
  const factory MidtransFailure.unexpectedError() = _UnexpectedError;
}
