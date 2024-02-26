/// Configuration class for Midtrans integration.
///
/// Use this class to configure Midtrans SDK with your merchant information and settings.
class MidtransConfig {
  /// Your Midtrans client key provided by the merchant dashboard.
  final String merchantClientKey;

  /// Base URL for Midtrans API endpoints.
  final String merchantUrl;

  /// Whether logging is enabled or not. Default is `true`.
  final bool enableLog;

  /// URL to handle GoPay callback.
  ///
  /// For more information about GoPay callback configuration, see:
  /// - [GoPay iOS Configuration](https://docs.midtrans.com/reference/features-1#gopay-ios-configuration)
  /// - [GoPay Android Configuration](https://docs.midtrans.com/reference/features-1#gopay-android-configuration)
  final String? gopayCallbackUrl;

  /// URL to handle ShopeePay callback deep link.
  ///
  /// For ShopeePay callback deep link configuration, see:
  /// [ShopeePay Callback Deep Link](https://docs.midtrans.com/reference/features-1#shopeepay-callback-deeplink)
  final String? shopeePayCallbackUrl;

  /// Configuration for Permata Virtual Account payment method.
  final PermataVa? permataVa;

  /// Configuration for BCA Virtual Account payment method.
  final BcaVa? bcaVa;

  /// Configuration for BNI Virtual Account payment method.
  final BniVa? bniVa;

  /// Configuration for payment type.
  final PaymentTypeConfig? paymentTypeConfig;

  /// Creates a new instance of [MidtransConfig].
  ///
  /// [merchantClientKey] and [merchantUrl] are required parameters.
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

  /// Converts the configuration to a JSON representation.
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
      'paymentTypeConfig': paymentTypeConfig?.toString().split('.').last,
    }..removeWhere((_, value) => value == null);
  }
}

/// Configuration for Permata Virtual Account payment method.
class PermataVa {
  /// Virtual Account number.
  final String? vaNumber;

  /// Name of the recipient.
  final String? recipientName;

  /// Creates a new instance of [PermataVa].
  PermataVa({
    this.vaNumber,
    this.recipientName,
  });

  /// Converts the configuration to a JSON representation.
  Map<String, dynamic> toJson() => {
        'vaNumber': vaNumber,
        'recipientName': recipientName,
      }..removeWhere((key, value) => value == null);
}

/// Configuration for BCA Virtual Account payment method.
class BcaVa {
  /// Virtual Account number.
  final String? vaNumber;

  /// Sub-company code. Must be exactly 5 digits of a number.
  final String? subCompanyCode;

  /// Creates a new instance of [BcaVa].
  BcaVa({
    this.vaNumber,
    this.subCompanyCode,
  });

  /// Converts the configuration to a JSON representation.
  Map<String, dynamic> toJson() => {
        'vaNumber': vaNumber,
        'subCompanyCode': subCompanyCode,
      }..removeWhere((key, value) => value == null);
}

/// Configuration for BNI Virtual Account payment method.
class BniVa {
  /// Virtual Account number.
  final String? vaNumber;

  /// Creates a new instance of [BniVa].
  BniVa({
    this.vaNumber,
  });

  /// Converts the configuration to a JSON representation.
  Map<String, dynamic> toJson() => {
        'vaNumber': vaNumber,
      }..removeWhere((key, value) => value == null);
}

/// Enum representing payment type configuration.
enum PaymentTypeConfig {
  /// Two clicks payment configuration.
  ///
  /// For more information, see [Two Clicks Payment](https://docs.midtrans.com/reference/features-1#two-clicks-payment).
  twoClickPayment,

  /// One click payment configuration.
  ///
  /// For more information, see [One Click Payment](https://docs.midtrans.com/reference/features-1#one-click-payment).
  oneClickPayment,
}
