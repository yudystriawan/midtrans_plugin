import 'package:flutter_test/flutter_test.dart';
import 'package:midtrans_plugin/models/transaction_result.dart';

void main() {
  group('$TransactionResult', () {
    test('fromJson() converts JSON correctly', () {
      final json = {
        'statusMessage': 'Transaction successful',
        'paymentType': 'Credit Card',
        'transactionStatus': 'Success',
        'transactionId': '1234567890',
        'orderId': '9876543210',
        'isCanceled': false,
        'isFailed': false,
      };

      final transactionResult = TransactionResult.fromJson(json);

      expect(transactionResult.statusMessage, 'Transaction successful');
      expect(transactionResult.paymentType, 'Credit Card');
      expect(transactionResult.transactionStatus, 'Success');
      expect(transactionResult.transactionId, '1234567890');
      expect(transactionResult.orderId, '9876543210');
      expect(transactionResult.isCanceled, false);
      expect(transactionResult.isFailed, false);
    });

    test('toJson() returns correct JSON representation', () {
      final transactionResult = TransactionResult(
        statusMessage: 'Transaction successful',
        paymentType: 'Credit Card',
        transactionStatus: 'Success',
        transactionId: '1234567890',
        orderId: '9876543210',
        isCanceled: false,
        isFailed: false,
      );

      final expectedJson = {
        'statusMessage': 'Transaction successful',
        'paymentType': 'Credit Card',
        'transactionStatus': 'Success',
        'transactionId': '1234567890',
        'orderId': '9876543210',
        'isCanceled': false,
        'isFailed': false,
      };

      expect(transactionResult.toJson(), expectedJson);
    });

    test('toString() returns correct string representation', () {
      final transactionResult = TransactionResult(
        statusMessage: 'Transaction successful',
        paymentType: 'Credit Card',
        transactionStatus: 'Success',
        transactionId: '1234567890',
        orderId: '9876543210',
        isCanceled: false,
        isFailed: false,
      );

      const expectedString = 'TransactionResult('
          'message: Transaction successful, '
          'paymentType: Credit Card, '
          'status: Success, '
          'transactionId: 1234567890, '
          'orderId: 9876543210, '
          'isCanceled: false, '
          'isFailed: false)';

      expect(transactionResult.toString(), expectedString);
    });
  });
}
