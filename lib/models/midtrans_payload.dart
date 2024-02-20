class TransactionDetails {
  final String orderId;
  final double grossAmount;
  final String? currency;

  TransactionDetails({
    required this.orderId,
    required this.grossAmount,
    this.currency = "IDR",
  });

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'grossAmount': grossAmount,
        'currency': currency,
      }..removeWhere((key, value) => value == null);
}

class ItemDetail {
  final String? id;
  final double price;
  final int quantity;
  final String name;
  final String? brand;
  final String? category;
  final String? merchantName;
  final String? url;

  ItemDetail({
    this.id,
    required this.price,
    required this.quantity,
    required this.name,
    this.brand,
    this.category,
    this.merchantName,
    this.url,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'quantity': quantity,
        'name': name,
        'brand': brand,
        'category': category,
        'merchantName': merchantName,
        'url': url,
      }..removeWhere((key, value) => value == null);
}

class BillingAddress {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? address;
  final String? city;
  final String? postalCode;
  final String? countryCode;

  BillingAddress({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.postalCode,
    this.countryCode,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'address': address,
        'city': city,
        'postalCode': postalCode,
        'countryCode': countryCode,
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

class CreditCardInstallmentTerms {
  final List<int> bni;
  final List<int> mandiri;
  final List<int> cimb;
  final List<int> bca;
  final List<int> offline;

  CreditCardInstallmentTerms({
    required this.bni,
    required this.mandiri,
    required this.cimb,
    required this.bca,
    required this.offline,
  });

  Map<String, dynamic> toJson() => {
        'bni': bni,
        'mandiri': mandiri,
        'cimb': cimb,
        'bca': bca,
        'offline': offline,
      }..removeWhere((key, value) => value == null);
}

class CreditCard {
  final bool? secure;
  final String? channel;
  final String? bank;
  final Map<String, CreditCardInstallmentTerms>? installment;
  final List<String>? whitelistBins;
  final Map<String, String>? dynamicDescriptor;

  CreditCard({
    this.secure,
    this.channel,
    this.bank,
    this.installment,
    this.whitelistBins,
    this.dynamicDescriptor,
  });

  Map<String, dynamic> toJson() => {
        'secure': secure,
        'channel': channel,
        'bank': bank,
        'installment':
            installment?.map((key, value) => MapEntry(key, value.toJson())),
        'whitelistBins': whitelistBins,
        'dynamicDescriptor': dynamicDescriptor,
      }..removeWhere((key, value) => value == null);
}

class FreeText {
  final List<FreeTextItem>? inquiry;
  final List<FreeTextItem>? payment;

  FreeText({
    this.inquiry,
    this.payment,
  });

  Map<String, dynamic> toJson() => {
        'inquiry': inquiry?.map((item) => item.toJson()).toList(),
        'payment': payment?.map((item) => item.toJson()).toList(),
      }..removeWhere((key, value) => value == null);
}

class FreeTextItem {
  final String en;
  final String id;

  FreeTextItem({
    required this.en,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'en': en,
        'id': id,
      }..removeWhere((key, value) => value == null);
}

class BcaVa {
  final String? vaNumber;
  final String? subCompanyCode;
  final FreeText? freeText;

  BcaVa({
    this.vaNumber,
    this.subCompanyCode,
    this.freeText,
  });

  Map<String, dynamic> toJson() => {
        'vaNumber': vaNumber,
        'subCompanyCode': subCompanyCode,
        'freeText': freeText?.toJson(),
      }..removeWhere((key, value) => value == null);
}

class ShopeePay {
  final String? callbackUrl;

  ShopeePay({
    this.callbackUrl,
  });

  Map<String, dynamic> toJson() => {
        'callbackUrl': callbackUrl,
      }..removeWhere((key, value) => value == null);
}

class GoPay {
  final bool? enableCallback;
  final String? callbackUrl;

  GoPay({
    this.enableCallback,
    this.callbackUrl,
  });

  Map<String, dynamic> toJson() => {
        'enableCallback': enableCallback,
        'callbackUrl': callbackUrl,
      }..removeWhere((key, value) => value == null);
}

class Callbacks {
  final String? finish;

  Callbacks({
    this.finish,
  });

  Map<String, dynamic> toJson() => {
        'finish': finish,
      }..removeWhere((key, value) => value == null);
}

class Expiry {
  final String startTime;
  final String unit;
  final int duration;

  Expiry({
    required this.startTime,
    required this.unit,
    required this.duration,
  });

  Map<String, dynamic> toJson() => {
        'startTime': startTime,
        'unit': unit,
        'duration': duration,
      }..removeWhere((key, value) => value == null);
}

class PageExpiry {
  final int duration;
  final String unit;

  PageExpiry({
    required this.duration,
    required this.unit,
  });

  Map<String, dynamic> toJson() => {
        'duration': duration,
        'unit': unit,
      }..removeWhere((key, value) => value == null);
}

class Recurring {
  final bool required;
  final String startTime;
  final String intervalUnit;

  Recurring({
    required this.required,
    required this.startTime,
    required this.intervalUnit,
  });

  Map<String, dynamic> toJson() => {
        'required': required,
        'startTime': startTime,
        'intervalUnit': intervalUnit,
      }..removeWhere((key, value) => value == null);
}

class BniVa {
  final String? vaNumber;

  BniVa({
    this.vaNumber,
  });

  Map<String, dynamic> toJson() => {
        'vaNumber': vaNumber,
      }..removeWhere((key, value) => value == null);
}

class CimbVa {
  final String? vaNumber;

  CimbVa({
    this.vaNumber,
  });

  Map<String, dynamic> toJson() => {
        'vaNumber': vaNumber,
      }..removeWhere((key, value) => value == null);
}

class BriVa {
  final String? vaNumber;

  BriVa({
    this.vaNumber,
  });

  Map<String, dynamic> toJson() => {
        'vaNumber': vaNumber,
      }..removeWhere((key, value) => value == null);
}

class PermataVa {
  final String? vaNumber;
  final String? recipientName;

  PermataVa({
    this.vaNumber,
    this.recipientName,
  });

  Map<String, dynamic> toJson() => {
        'vaNumber': vaNumber,
        'recipientName': recipientName,
      }..removeWhere((key, value) => value == null);
}

class MidtransPayload {
  final TransactionDetails transactionDetails;
  final List<ItemDetail> itemDetails;
  final CustomerDetails? customerDetails;
  final List<String>? enabledPayments;
  final CreditCard? creditCard;
  final BcaVa? bcaVa;
  final BniVa? bniVa;
  final BriVa? briVa;
  final CimbVa? cimbVa;
  final PermataVa? permataVa;
  final ShopeePay? shopeePay;
  final GoPay? goPay;
  final Callbacks? callbacks;
  final Map<String, dynamic>? uobEzpay;
  final Expiry? expiry;
  final PageExpiry? pageExpiry;
  final Recurring? recurring;
  final String? customField1;
  final String? customField2;
  final String? customField3;

  MidtransPayload({
    required this.transactionDetails,
    required this.itemDetails,
    this.customerDetails,
    this.enabledPayments,
    this.creditCard,
    this.bcaVa,
    this.bniVa,
    this.briVa,
    this.cimbVa,
    this.permataVa,
    this.shopeePay,
    this.goPay,
    this.callbacks,
    this.uobEzpay,
    this.expiry,
    this.pageExpiry,
    this.recurring,
    this.customField1,
    this.customField2,
    this.customField3,
  });

  Map<String, dynamic> toJson() => {
        'transactionDetails': transactionDetails.toJson(),
        'itemDetails': itemDetails.map((e) => e.toJson()).toList(),
        'customerDetails': customerDetails?.toJson(),
        'enabledPayments': enabledPayments,
        'creditCard': creditCard?.toJson(),
        'bcaVa': bcaVa?.toJson(),
        'bniVa': bniVa?.toJson(),
        'briVa': briVa?.toJson(),
        'cimbVa': cimbVa?.toJson(),
        'permataVa': permataVa?.toJson(),
        'shopeePay': shopeePay?.toJson(),
        'goPay': goPay?.toJson(),
        'callbacks': callbacks?.toJson(),
        'uobEzpay': uobEzpay,
        'expiry': expiry?.toJson(),
        'pageExpiry': pageExpiry?.toJson(),
        'recurring': recurring?.toJson(),
        'customField1': customField1,
        'customField2': customField2,
        'customField3': customField3,
      }..removeWhere((key, value) => value == null);
}
