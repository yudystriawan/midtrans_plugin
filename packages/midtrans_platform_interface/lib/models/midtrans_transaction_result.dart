import 'package:freezed_annotation/freezed_annotation.dart';

part 'midtrans_transaction_result.freezed.dart';
part 'midtrans_transaction_result.g.dart';

@freezed
class MidtransTransactionResult with _$MidtransTransactionResult {
  const factory MidtransTransactionResult({
    String? transactionId,
    required String status,
    required String paymentType,
    String? message,
  }) = _MidtransTransactionResult;

  factory MidtransTransactionResult.fromJson(Map<String, dynamic> json) =>
      _$MidtransTransactionResultFromJson(json);
}
