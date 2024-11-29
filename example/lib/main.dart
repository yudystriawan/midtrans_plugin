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
    const snapToken = '121859b1-db66-4a82-82db-16f4f857d741';

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final payload = MidtransCheckoutPayload(
                          transactionDetails: MidtransTransactionDetails(
                            orderId: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
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
                  const SizedBox(height: 18),
                  if (snapToken.isNotEmpty)
                    ElevatedButton(
                      onPressed: () async {
                        await Midtrans.instance.checkoutWithToken(snapToken);
                      },
                      child: const Text('pay with token'),
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
                              Clipboard.setData(ClipboardData(
                                  text: data.transactionId ?? ''));
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
