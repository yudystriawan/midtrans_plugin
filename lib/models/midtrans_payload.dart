import 'package:intl/intl.dart';

/// Represents the details of a transaction.
class TransactionDetails {
  /// The order ID associated with the transaction.
  final String orderId;

  /// The gross amount of the transaction.
  final double grossAmount;

  /// Creates a new instance of [TransactionDetails].
  ///
  /// [orderId] is the unique identifier for the order.
  /// [grossAmount] is the total amount of the transaction.
  TransactionDetails({
    required this.orderId,
    required this.grossAmount,
  });

  /// Converts the transaction details to a JSON representation.
  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'grossAmount': grossAmount,
      }..removeWhere((key, value) => value == null);
}

/// Represents details of an item.
class ItemDetail {
  /// The unique identifier for the item.
  final String id;

  /// The price of the item.
  final double price;

  /// The quantity of the item.
  final int quantity;

  /// The name of the item.
  final String name;

  /// The URL of the item's image.
  final String? imageUrl;

  /// Creates a new instance of [ItemDetail].
  ///
  /// [id] is the unique identifier for the item.
  /// [price] is the price of the item.
  /// [quantity] is the quantity of the item.
  /// [name] is the name of the item.
  /// [imageUrl] is the URL of the item's image.
  ItemDetail({
    required this.id,
    required this.price,
    required this.quantity,
    required this.name,
    this.imageUrl,
  });

  /// Converts the item details to a JSON representation.
  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'quantity': quantity,
        'name': name,
        'imageUrl': imageUrl,
      }..removeWhere((key, value) => value == null);
}

/// Represents the billing address of a customer.
class BillingAddress {
  /// The first name of the customer.
  final String? firstName;

  /// The last name of the customer.
  final String? lastName;

  /// The phone number of the customer.
  final String? phone;

  /// The address of the customer.
  final String? address;

  /// The city of the customer.
  final String? city;

  /// The postal code of the customer.
  final String? postalCode;

  /// Creates a new instance of [BillingAddress].
  ///
  /// [firstName] is the first name of the customer.
  /// [lastName] is the last name of the customer.
  /// [phone] is the phone number of the customer.
  /// [address] is the address of the customer.
  /// [city] is the city of the customer.
  /// [postalCode] is the postal code of the customer.
  BillingAddress({
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.city,
    this.postalCode,
  });

  /// Converts the billing address to a JSON representation.
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'address': address,
        'city': city,
        'postalCode': postalCode,
      }..removeWhere((key, value) => value == null);
}

/// Represents the details of a customer.
class CustomerDetails {
  /// The first name of the customer.
  final String? firstName;

  /// The last name of the customer.
  final String? lastName;

  /// The email address of the customer.
  final String? email;

  /// The phone number of the customer.
  final String? phone;

  /// The billing address of the customer.
  final BillingAddress? billingAddress;

  /// The shipping address of the customer.
  final BillingAddress? shippingAddress;

  /// Creates a new instance of [CustomerDetails].
  ///
  /// [firstName] is the first name of the customer.
  /// [lastName] is the last name of the customer.
  /// [email] is the email address of the customer.
  /// [phone] is the phone number of the customer.
  /// [billingAddress] is the billing address of the customer.
  /// [shippingAddress] is the shipping address of the customer.
  CustomerDetails({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.billingAddress,
    this.shippingAddress,
  });

  /// Converts the customer details to a JSON representation.
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'billingAddress': billingAddress?.toJson(),
        'shippingAddress': shippingAddress?.toJson(),
      }..removeWhere((key, value) => value == null);
}

/// Represents the unit for expiry duration.
enum ExpireUnit {
  /// Minutes.
  minutes,

  /// Hours.
  hours,

  /// Days.
  days,
}

/// Represents the expiry configuration.
class Expiry {
  /// The start time for the expiry duration.
  final DateTime startTime;

  /// The unit for the expiry duration.
  final ExpireUnit unit;

  /// The duration for the expiry.
  final int duration;

  /// Creates a new instance of [Expiry].
  ///
  /// [startTime] is the start time for the expiry duration.
  /// [unit] is the unit for the expiry duration.
  /// [duration] is the duration for the expiry.
  Expiry({
    required this.startTime,
    this.unit = ExpireUnit.days,
    this.duration = 1,
  });

  /// Converts the expiry configuration to a JSON representation.
  Map<String, dynamic> toJson() => {
        'startTime': DateFormat("yyyy-MM-dd HH:mm:ss Z").format(startTime),
        'unit': unit.toString().split('.').last,
        'duration': duration,
      }..removeWhere((_, value) => value == null);
}

/// Represents the payload for Midtrans integration.
class MidtransPayload {
  /// The transaction details.
  final TransactionDetails transactionDetails;

  /// The item details.
  final List<ItemDetail> itemDetails;

  /// The customer details.
  final CustomerDetails? customerDetails;

  /// The expiry configuration.
  final Expiry? expiry;

  /// Creates a new instance of [MidtransPayload].
  ///
  /// [transactionDetails] are the details of the transaction.
  /// [itemDetails] are the details of the items.
  /// [customerDetails] are the details of the customer.
  /// [expiry] is the expiry configuration.
  MidtransPayload({
    required this.transactionDetails,
    required this.itemDetails,
    this.customerDetails,
    this.expiry,
  });

  /// Converts the payload to a JSON representation.
  Map<String, dynamic> toJson() => {
        'transactionDetails': transactionDetails.toJson(),
        'itemDetails': itemDetails.map((e) => e.toJson()).toList(),
        'customerDetails': customerDetails?.toJson(),
        'expiry': expiry?.toJson(),
      }..removeWhere((key, value) => value == null);
}
