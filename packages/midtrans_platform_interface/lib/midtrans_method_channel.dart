import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:midtrans_platform_interface/midtrans_plugin.dart';

/// An implementation of [MidtransPluginPlatform] that uses method channels.
class MethodChannelMidtransPlugin extends MidtransPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('midtrans_plugin');

  @override
  Future<void> initialize(MidtransConfig config) async {
    try {
      final payload = {'config': config.toJson()};
      await methodChannel.invokeMethod('initialize', payload);
    } on PlatformException catch (e) {
      throw MidtransFailure.unexpectedError(
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Future<void> checkout(String snapToken) async {
    try {
      final payload = {'snapToken': snapToken};
      await methodChannel.invokeMethod('checkout', payload);
    } on PlatformException catch (e) {
      throw MidtransFailure.unexpectedError(
        code: e.code,
        message: e.message,
      );
    }
  }
}
