import 'package:freezed_annotation/freezed_annotation.dart';

part 'midtrans_item_details.freezed.dart';
part 'midtrans_item_details.g.dart';

@Freezed(unionValueCase: FreezedUnionCase.snake)
class MidtransItemDetails with _$MidtransItemDetails {
  const factory MidtransItemDetails({
    String? id,
    required int price,
    required int quantity,
    required String name,
    String? brand,
    String? category,
    String? merchantName,
    String? url,
  }) = _MidtransItemDetails;

  factory MidtransItemDetails.fromJson(Map<String, dynamic> json) =>
      _$MidtransItemDetailsFromJson(json);
}
