import 'package:flutter/services.dart';
import 'package:midtrans_plugin/models/midtrans_config.dart';
import 'package:midtrans_plugin/models/midtrans_payload.dart';
import 'package:midtrans_plugin/models/transaction_result.dart';

import 'midtrans_plugin_platform_interface.dart';

class MidtransPlugin {
  static MidtransPlugin? _instance;
  static const _channel = MethodChannel('midtrans_plugin');
  TransactionResultCallback? _callback;

  MidtransPlugin._() {
    _channel.setMethodCallHandler(_onMethodCallHandler);
  }

  static MidtransPlugin get instance {
    if (_instance == null) {
      throw UnimplementedError('MidtransPlugin instance not initialized yet!');
    }

    return _instance!;
  }

  static Future<void> initialize(MidtransConfig config) async {
    if (_instance != null) return;

    final result = await MidtransPluginPlatform.instance.initialize(config);

    if (result ?? false) {
      _instance = MidtransPlugin._();
    }

    return;
  }

  Future<void> startPayment(MidtransPayload payload) {
    return MidtransPluginPlatform.instance.startPayment(payload);
  }

  void setTransactionResultCallback(TransactionResultCallback callback) {
    _callback = callback;
  }

  Future _onMethodCallHandler(MethodCall call) async {
    if (call.method == 'onTransactionResult') {
      final arguments = Map<String, dynamic>.from(call.arguments);
      _callback?.call(TransactionResult.fromJson(arguments));
    }
    return;
  }
}
