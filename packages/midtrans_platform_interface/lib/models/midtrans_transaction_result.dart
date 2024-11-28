import 'package:freezed_annotation/freezed_annotation.dart';

part 'midtrans_transaction_result.freezed.dart';
part 'midtrans_transaction_result.g.dart';

@freezed
class MidtransTransactionResult with _$MidtransTransactionResult {
  const factory MidtransTransactionResult({
    String? transactionId,
    String? status,
    String? paymentType,
    String? message,
    @Default(false) bool isCancelled,
    @Default(false) bool isFailed,
  }) = _MidtransTransactionResult;

  factory MidtransTransactionResult.fromJson(Map<String, dynamic> json) =>
      _$MidtransTransactionResultFromJson(json);
}
