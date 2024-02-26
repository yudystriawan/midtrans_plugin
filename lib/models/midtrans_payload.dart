class TransactionDetails {
  final String orderId;
  final double grossAmount;

  TransactionDetails({
    required this.orderId,
    required this.grossAmount,
  });

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'grossAmount': grossAmount,
      }..removeWhere((key, value) => value == null);
}

class ItemDetail {
  final String id;
  final double price;
  final int quantity;
  final String name;
  final String? imageUrl;

  ItemDetail({
    required this.id,
    required this.price,
    required this.quantity,
    required this.name,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'quantity': quantity,
        'name': name,
        'imageUrl': imageUrl,
      }..removeWhere((key, value) => value == null);
}

class BillingAddress {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? address;
  final String? city;
  final String? postalCode;

  BillingAddress({
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.city,
    this.postalCode,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'address': address,
        'city': city,
        'postalCode': postalCode,
      }..removeWhere((key, value) => value == null);
}

class CustomerDetails {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final BillingAddress? billingAddress;
  final BillingAddress? shippingAddress;

  CustomerDetails({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.billingAddress,
    this.shippingAddress,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'billingAddress': billingAddress?.toJson(),
        'shippingAddress': shippingAddress?.toJson(),
      }..removeWhere((key, value) => value == null);
}

enum ExpireUnit {
  minutes,
  hours,
  days,
}

class Expiry {
  final DateTime? startTime;
  final ExpireUnit unit;
  final int duration;

  Expiry({
    required this.startTime,
    this.unit = ExpireUnit.days,
    this.duration = 1,
  });

  Map<String, dynamic> toJson() => {
        'startTime': startTime,
        'unit': unit.toString().split('.').last,
        'duration': duration,
      }..removeWhere((_, value) => value == null);
}

class MidtransPayload {
  final TransactionDetails transactionDetails;
  final List<ItemDetail> itemDetails;
  final CustomerDetails? customerDetails;
  final Expiry? expiry;

  MidtransPayload({
    required this.transactionDetails,
    required this.itemDetails,
    this.customerDetails,
    this.expiry,
  });

  Map<String, dynamic> toJson() => {
        'transactionDetails': transactionDetails.toJson(),
        'itemDetails': itemDetails.map((e) => e.toJson()).toList(),
        'customerDetails': customerDetails?.toJson(),
        'expiry': expiry?.toJson(),
      }..removeWhere((key, value) => value == null);
}
