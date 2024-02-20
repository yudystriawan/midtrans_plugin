import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:midtrans_plugin/models/midtrans_config.dart';
import 'package:midtrans_plugin/models/midtrans_payload.dart';

import 'midtrans_plugin_platform_interface.dart';

/// An implementation of [MidtransPluginPlatform] that uses method channels.
class MethodChannelMidtransPlugin extends MidtransPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('midtrans_plugin');

  @override
  Future<bool?> initialize(MidtransConfig config) async {
    try {
      final arguments = config.toJson();
      return await methodChannel.invokeMethod<bool?>('initialize', arguments);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> startPayment(MidtransPayload payload) async {
    try {
      final arguments = payload.toJson();
      return await methodChannel.invokeMethod('startPayment', arguments);
    } catch (e) {
      rethrow;
    }
  }
}
