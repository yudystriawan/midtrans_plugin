# Midtrans Plugin

This plugin is a unofficial implementation for integrating Midtrans payment gateway into your Flutter applications. Midtrans is tech-based finance that offers a payment gateway in Indonesia. Supports many online payment methods and transfers funds (disbursement) to make it easier for customers in business transactions and to focus on growing your business with the option of managing all payment processes.

## Introduction

This Flutter plugin aims to streamline the process of integrating Midtrans into your Flutter apps, providing developers with an easy-to-use interface for handling payments. With this plugin, you can facilitate secure transactions within your app, offering users a smooth payment experience.

## Features

- Seamless integration of Midtrans payment gateway.
- Customizable options for payment methods and configurations.
- Secure transaction handling to protect sensitive user data.
- Easy-to-use API for initiating and managing transactions.

## Installation

to use this plugin, follow these steps:

1. **Add dependency**: Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  midtrans_plugin: <latest_version>
```

2. **Install packages**: Run the following command in your terminal:

```
flutter pub get

```

## Usage

### 1. Import the package

```dart
import 'package:midtrans_plugin/midtrans_plugin.dart';
```

### 2. Initialize Midtrans

```dart
String merchantClientKey = 'clientKeySandbox';
String merchantUrl = 'merchantUrlSandbox';

if (!kDebugMode && !kProfileMode) {
    merchantClientKey = 'clientKeyProd';
    merchantUrl = 'merchantUrlProd';
}

final config = MidtransConfig(
    merchantClientKey: merchantClientKey,
    merchantUrl: merchantUrl,
);

await MidtransPlugin.initialize(config);
```

### 3. Make transaction

```dart
try {

final transactionDetails = TransactionDetails(
    orderId: 'ORDER-${DateTime.now().millisecondsSinceEpoch}',
    grossAmount: 10.0,
);

final itemDetails = [
    ItemDetail(
        id: 'product_a',
        price: 10.0,
        quantity: 1,
        name: 'Product A',
    )
];

final customerDetails = CustomerDetails(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
    phone: '08123456789',
    billingAddress: BillingAddress(
        firstName: 'John',
        lastName: 'Doe',
        address: 'Jl. Buntu No. 2',
        city: 'Jakarta',
        phone: '08123456789',
        postalCode: '112233',
    ),
);

await MidtransPlugin.instance.startPayment(
    MidtransPayload(
        transactionDetails: transactionDetails,
        itemDetails: itemDetails,
        customerDetails: customerDetails,
    ),
);

} catch (e) {
    print('an error occured $e');
}
```

### 4. Handle Payment Result

```dart
MidtransPlugin.onTransactionResult.listen((result) {
    print('[transactionResult] $result');
});

```
