import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:midtrans_platform_interface/midtrans_plugin.dart';

part 'midtrans_checkout_payload.freezed.dart';
part 'midtrans_checkout_payload.g.dart';

@freezed
class MidtransCheckoutPayload with _$MidtransCheckoutPayload {
  const factory MidtransCheckoutPayload({
    required MidtransTransactionDetails transactionDetails,
    List<MidtransItemDetails>? itemDetails,
  }) = _MidtransCheckoutPayload;

  factory MidtransCheckoutPayload.fromJson(Map<String, dynamic> json) =>
      _$MidtransCheckoutPayloadFromJson(json);
}
