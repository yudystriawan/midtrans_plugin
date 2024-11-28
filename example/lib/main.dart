// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:midtrans_plugin/midtrans_plugin.dart';
// import 'package:midtrans_plugin/models/midtrans_config.dart';
// import 'package:midtrans_plugin/models/midtrans_payload.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   String merchantClientKey = 'clientKeySandbox';
//   String merchantUrl = 'merchantUrlSandbox';
//   if (!kDebugMode && !kProfileMode) {
//     merchantClientKey = 'clientKeyProd';
//     merchantUrl = 'merchantUrlProd';
//   }

//   final config = MidtransConfig(
//     merchantClientKey: merchantClientKey,
//     merchantUrl: merchantUrl,
//     paymentTypeConfig: PaymentTypeConfig.twoClickPayment,
//   );

//   await MidtransPlugin.initialize(config);

//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String _message = '';
//   bool _isLoading = false;

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();

//     MidtransPlugin.onTransactionResult.listen((result) {
//       log('[transactionResult] $result');
//       final transactionID = result.transactionId;
//       final status = result.transactionStatus;

//       String message = '';
//       if (result.isCanceled) message = 'Canceled';

//       if (result.isFailed) message = 'Payment failed';

//       if (transactionID != null && transactionID.isNotEmpty) {
//         message += 'transactionID: $transactionID';
//       }
//       if (status != null && status.isNotEmpty) message += ' $status';

//       ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
//         SnackBar(content: Text(message)),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               if (_message.isNotEmpty) Text(_message),
//               if (_isLoading)
//                 const CircularProgressIndicator.adaptive()
//               else
//                 ElevatedButton(
//                   onPressed: () async {
//                     setState(() {
//                       _isLoading = true;
//                       _message = '';
//                     });

//                     try {
//                       final transactionDetails = TransactionDetails(
//                         orderId:
//                             'ORDER-${DateTime.now().millisecondsSinceEpoch}',
//                         grossAmount: 10.0,
//                       );

//                       final itemDetails = [
//                         ItemDetail(
//                           id: 'product_a',
//                           price: 10.0,
//                           quantity: 1,
//                           name: 'Product A',
//                         )
//                       ];

//                       final customerDetails = CustomerDetails(
//                         firstName: 'John',
//                         lastName: 'Doe',
//                         email: 'john@example.com',
//                         phone: '08123456789',
//                         billingAddress: BillingAddress(
//                           firstName: 'John',
//                           lastName: 'Doe',
//                           address: 'Jl. Buntu No. 2',
//                           city: 'Jakarta',
//                           phone: '08123456789',
//                           postalCode: '112233',
//                         ),
//                       );

//                       await MidtransPlugin.instance.startPayment(
//                         MidtransPayload(
//                           transactionDetails: transactionDetails,
//                           itemDetails: itemDetails,
//                           customerDetails: customerDetails,
//                         ),
//                       );

//                       setState(() {
//                         _isLoading = false;
//                       });
//                     } catch (e) {
//                       log('an error occured', error: e);
//                       setState(() {
//                         _isLoading = false;
//                         _message = 'Cannot pay';
//                       });
//                     }
//                   },
//                   child: const Text('Pay'),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:midtrans/midtrans.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const config = MidtransConfig(
    clientKey: 'SB-Mid-client-V8p1M-DRoTXmhvsz',
    baseUrl: 'https://midtrans-server.firebaseapp.com/api/',
    isProduction: false,
    enableLog: false,
  );

  try {
    await Midtrans.initialize(config);
    debugPrint('initialized');
  } catch (e) {
    debugPrint('Failed to initialize Midtrans: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final payload = MidtransCheckoutPayload(
                        transactionDetails: MidtransTransactionDetails(
                          orderId:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          grossAmount: 10000,
                        ),
                        itemDetails: [
                          const MidtransItemDetails(
                            id: 'product_a',
                            price: 5000,
                            quantity: 1,
                            name: 'Product A',
                          ),
                          const MidtransItemDetails(
                            id: 'product_b',
                            price: 5000,
                            quantity: 1,
                            name: 'Product B',
                          ),
                        ],
                      );

                      await Midtrans.instance.checkout(payload);
                    } on MidtransFailure catch (e) {
                      final message = e.when(
                        unexpectedError: (code, message) =>
                            'error code $code, $message',
                        initializeFailed: () => 'Failed to initialize',
                      );

                      debugPrint('Failed to checkout: $message');
                    }
                  },
                  child: const Text('pay'),
                ),
                const Divider(),
                StreamBuilder(
                  stream: Midtrans.instance.onTransactionResult,
                  builder: (context, snapshot) {
                    final hasData = snapshot.hasData;
                    if (!hasData) return const Text('No result data');

                    final data = snapshot.data!;

                    return Column(
                      children: [
                        TransactionResultRow(
                          label: 'Transaction ID: ',
                          data: data.transactionId ?? '',
                        ),
                        const SizedBox(height: 4),
                        TransactionResultRow(
                          label: 'Status: ',
                          data: data.status ?? '',
                        ),
                        const SizedBox(height: 4),
                        TransactionResultRow(
                          label: 'Payment Type: ',
                          data: data.paymentType ?? '',
                        ),
                        const SizedBox(height: 4),
                        TransactionResultRow(
                          label: 'Message: ',
                          data: data.message ?? '',
                        ),
                        const SizedBox(height: 4),
                        TransactionResultRow(
                          label: 'Is Canceled: ',
                          data: data.isCancelled.toString(),
                        ),
                        const SizedBox(height: 4),
                        TransactionResultRow(
                          label: 'Is Failed: ',
                          data: data.isFailed.toString(),
                        ),
                        const SizedBox(height: 4),
                        TextButton.icon(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: data.transactionId ?? ''));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Transaction ID copied'),
                              ),
                            );
                          },
                          label: const Text('Copy Transaction ID'),
                          icon: const Icon(Icons.copy),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionResultRow extends StatelessWidget {
  const TransactionResultRow({
    super.key,
    required this.label,
    required this.data,
  });

  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const Spacer(),
        Expanded(
          child: Text(
            data,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
