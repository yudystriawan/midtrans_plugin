import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:midtrans_plugin/models/midtrans_config.dart';
import 'package:midtrans_plugin/models/midtrans_payload.dart';
import 'package:midtrans_plugin/models/transaction_result.dart';

import 'midtrans_plugin_platform_interface.dart';

/// An implementation of [MidtransPluginPlatform] that uses method channels.
class MethodChannelMidtransPlugin extends MidtransPluginPlatform {
  /// Create instance of [MethodChannelMidtransPlugin]
  MethodChannelMidtransPlugin();

  /// Internal stub class initializer.
  MethodChannelMidtransPlugin._();

  static MethodChannelMidtransPlugin get instance {
    return MethodChannelMidtransPlugin._();
  }

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  static const channel = MethodChannel('midtrans_plugin');

  late bool _isInitialized = false;

  static setMethodCallHandlers() {
    MethodChannelMidtransPlugin.channel.setMethodCallHandler((call) async {
      if (call.method == 'onTransactionResult') {
        final json = Map<String, dynamic>.from(call.arguments);
        MidtransPluginPlatform.onTransactionResult
            .add(TransactionResult.fromJson(json));
        return;
      }

      throw UnimplementedError('${call.method} has not been implemented');
    });
  }

  @override
  bool get isInitialized => _isInitialized;

  @override
  Future<bool?> initialize(MidtransConfig config) async {
    try {
      final result =
          await channel.invokeMethod<bool?>('initialize', config.toJson());
      _isInitialized = result ?? false;
      return _isInitialized;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> startPayment(MidtransPayload payload) async {
    try {
      final arguments = payload.toJson();
      return await channel.invokeMethod('startPayment', arguments);
    } catch (e) {
      rethrow;
    }
  }
}
