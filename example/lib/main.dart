import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:midtrans_plugin/midtrans_plugin.dart';
import 'package:midtrans_plugin/models/midtrans_config.dart';
import 'package:midtrans_plugin/models/midtrans_payload.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = MidtransConfig(
    merchantClientKey: 'SB-Mid-client-V8p1M-DRoTXmhvsz',
    merchantUrl: 'https://midtrans-server.web.app/api/',
  );
  await MidtransPlugin.initialize(config);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = '';
  bool _isLoading = false;

  final _midtransPlugin = MidtransPlugin.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _midtransPlugin.setTransactionResultCallback((result) {
      log('[transactionResult] $result');
      final transactionID = result.transactionId;
      final status = result.transactionStatus;

      String message = '';
      if (result.isCanceled) message = 'Canceled';

      if (result.isFailed) message = 'Payment failed';

      if (transactionID != null && transactionID.isNotEmpty) {
        message += 'transactionID: $transactionID';
      }
      if (status != null && status.isNotEmpty) message += ' $status';

      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
        SnackBar(content: Text(message)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_message.isNotEmpty) Text(_message),
              if (_isLoading)
                const CircularProgressIndicator.adaptive()
              else
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                      _message = '';
                    });

                    try {
                      String orderId =
                          'ORDER-${DateTime.now().millisecondsSinceEpoch}';
                      const grossAmount = 10.0;

                      await _midtransPlugin.startPayment(
                        MidtransPayload(
                          transactionDetails: TransactionDetails(
                            orderId: orderId,
                            grossAmount: grossAmount,
                          ),
                          itemDetails: [
                            ItemDetail(
                              id: 'product_a',
                              price: 10.0,
                              quantity: 1,
                              name: 'Product A',
                            )
                          ],
                        ),
                      );

                      setState(() {
                        _isLoading = false;
                      });
                    } catch (e) {
                      setState(() {
                        _isLoading = false;
                        _message = 'Cannot pay';
                      });
                    }
                  },
                  child: const Text('Pay'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
