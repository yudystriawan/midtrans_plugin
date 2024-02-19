import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:midtrans_plugin/midtrans_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = '';
  bool _isInitialized = false;
  bool _isLoading = false;

  final _midtransPlugin = MidtransPlugin();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    bool isInitialized = false;
    String message = '';

    try {
      isInitialized = await _midtransPlugin.initialize() ?? false;
    } on PlatformException {
      message = 'Something went wrong';
      isInitialized = false;
    }

    setState(() {
      _isInitialized = isInitialized;
      _message = message;
    });
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
                  onPressed: _isInitialized
                      ? () async {
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
                        }
                      : null,
                  child: const Text('Pay'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
