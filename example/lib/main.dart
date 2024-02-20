import 'dart:async';

import 'package:flutter/material.dart';
import 'package:midtrans_plugin/midtrans_plugin.dart';
import 'package:midtrans_plugin/models/midtrans_config.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                      await _midtransPlugin.startPayment();

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
