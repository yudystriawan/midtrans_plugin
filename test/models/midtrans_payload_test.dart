import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:midtrans_plugin/models/midtrans_payload.dart';

void main() {
  group('$MidtransPayload', () {
    test('toJson() returns correct JSON representation', () {
      final transactionDetails = TransactionDetails(
        orderId: '1234567890',
        grossAmount: 100.0,
      );

      final itemDetails = [
        ItemDetail(
          id: '1',
          price: 50.0,
          quantity: 2,
          name: 'Item 1',
          imageUrl: 'https://example.com/item1.jpg',
        ),
        ItemDetail(
          id: '2',
          price: 30.0,
          quantity: 1,
          name: 'Item 2',
        ),
      ];

      final customerDetails = CustomerDetails(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phone: '1234567890',
        billingAddress: BillingAddress(
          firstName: 'John',
          lastName: 'Doe',
          phone: '1234567890',
          address: '123 Main St',
          city: 'City',
          postalCode: '12345',
        ),
        shippingAddress: BillingAddress(
          firstName: 'John',
          lastName: 'Doe',
          phone: '1234567890',
          address: '123 Main St',
          city: 'City',
          postalCode: '12345',
        ),
      );

      final expiry = Expiry(
        startTime: DateTime.now(),
        unit: ExpireUnit.days,
        duration: 1,
      );

      final payload = MidtransPayload(
        transactionDetails: transactionDetails,
        itemDetails: itemDetails,
        customerDetails: customerDetails,
        expiry: expiry,
      );

      final expectedJson = {
        'transactionDetails': {
          'orderId': '1234567890',
          'grossAmount': 100.0,
        },
        'itemDetails': [
          {
            'id': '1',
            'price': 50.0,
            'quantity': 2,
            'name': 'Item 1',
            'imageUrl': 'https://example.com/item1.jpg',
          },
          {
            'id': '2',
            'price': 30.0,
            'quantity': 1,
            'name': 'Item 2',
          },
        ],
        'customerDetails': {
          'firstName': 'John',
          'lastName': 'Doe',
          'email': 'john.doe@example.com',
          'phone': '1234567890',
          'billingAddress': {
            'firstName': 'John',
            'lastName': 'Doe',
            'phone': '1234567890',
            'address': '123 Main St',
            'city': 'City',
            'postalCode': '12345',
          },
          'shippingAddress': {
            'firstName': 'John',
            'lastName': 'Doe',
            'phone': '1234567890',
            'address': '123 Main St',
            'city': 'City',
            'postalCode': '12345',
          },
        },
        'expiry': {
          'startTime': DateFormat(Expiry.kDateFormat).format(expiry.startTime),
          'unit': 'days',
          'duration': 1,
        },
      };

      expect(payload.toJson(), expectedJson);
    });
  });
}
