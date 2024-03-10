import 'package:flutter_test/flutter_test.dart';
import 'package:midtrans_plugin/models/midtrans_config.dart';

void main() {
  group('$MidtransConfig', () {
    test('toJson() returns correct JSON representation', () {
      final permataVa =
          PermataVa(vaNumber: '1234567890', recipientName: 'John Doe');
      final bcaVa = BcaVa(vaNumber: '0987654321', subCompanyCode: '12345');
      final bniVa = BniVa(vaNumber: '5678901234');
      const paymentTypeConfig = PaymentTypeConfig.twoClickPayment;

      final config = MidtransConfig(
        merchantClientKey: 'your_merchant_client_key',
        merchantUrl: 'https://your_merchant_url.com',
        gopayCallbackUrl: 'https://your_gopay_callback_url.com',
        shopeePayCallbackUrl: 'https://your_shopeepay_callback_url.com',
        permataVa: permataVa,
        bcaVa: bcaVa,
        bniVa: bniVa,
        paymentTypeConfig: paymentTypeConfig,
      );

      final expectedJson = {
        'merchantClientKey': 'your_merchant_client_key',
        'merchantUrl': 'https://your_merchant_url.com',
        'enableLog': true,
        'gopayCallbackUrl': 'https://your_gopay_callback_url.com',
        'shopeePayCallbackUrl': 'https://your_shopeepay_callback_url.com',
        'permataVa': {'vaNumber': '1234567890', 'recipientName': 'John Doe'},
        'bcaVa': {'vaNumber': '0987654321', 'subCompanyCode': '12345'},
        'bniVa': {'vaNumber': '5678901234'},
        'paymentTypeConfig': 'twoClickPayment',
      };

      expect(config.toJson(), expectedJson);
    });
  });
}
