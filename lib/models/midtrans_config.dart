class MidtransConfig {
  final String merchantClientKey;
  final String merchantUrl;
  final bool enableLog;

  /// see: https://docs.midtrans.com/reference/features-1#gopay-ios-configuration
  /// and https://docs.midtrans.com/reference/features-1#gopay-android-configuration
  final String? gopayCallbackUrl;

  /// see: https://docs.midtrans.com/reference/features-1#shopeepay-callback-deeplink
  final String? shopeePayCallbackUrl;
  final PermataVa? permataVa;
  final BcaVa? bcaVa;
  final BniVa? bniVa;
  final PaymentTypeConfig? paymentTypeConfig;

  MidtransConfig({
    required this.merchantClientKey,
    required this.merchantUrl,
    this.enableLog = true,
    this.gopayCallbackUrl,
    this.shopeePayCallbackUrl,
    this.permataVa,
    this.bcaVa,
    this.bniVa,
    this.paymentTypeConfig,
  });

  Map<String, dynamic> toJson() {
    return {
      'merchantClientKey': merchantClientKey,
      'merchantUrl': merchantUrl,
      'enableLog': enableLog,
      'gopayCallbackUrl': gopayCallbackUrl,
      'shopeePayCallbackUrl': shopeePayCallbackUrl,
      'permataVa': permataVa?.toJson(),
      'bcaVa': bcaVa?.toJson(),
      'bniVa': bniVa?.toJson(),
      'peymentTypeConfig': paymentTypeConfig?.toString().split('.').last,
    }..removeWhere((_, value) => value == null);
  }
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

class BcaVa {
  final String? vaNumber;

  /// sub company code must be exactly 5 digits of number
  final String? subCompanyCode;

  BcaVa({
    this.vaNumber,
    this.subCompanyCode,
  });

  Map<String, dynamic> toJson() => {
        'vaNumber': vaNumber,
        'subCompanyCode': subCompanyCode,
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

enum PaymentTypeConfig {
  /// see https://docs.midtrans.com/reference/features-1#two-clicks-payment.
  twoClickPayment,

  /// see https://docs.midtrans.com/reference/features-1#one-click-payment
  oneClickPayment,
}
