import 'package:freezed_annotation/freezed_annotation.dart';

part 'midtrans_transaction_details.freezed.dart';
part 'midtrans_transaction_details.g.dart';

@freezed
class MidtransTransactionDetails with _$MidtransTransactionDetails {
  const factory MidtransTransactionDetails({
    required String orderId,
    required int grossAmount,
  }) = _MidtransTransactionDetails;

  factory MidtransTransactionDetails.fromJson(Map<String, dynamic> json) =>
      _$MidtransTransactionDetailsFromJson(json);
}
