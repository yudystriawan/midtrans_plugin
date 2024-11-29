import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:midtrans_platform_interface/midtrans_plugin.dart';

/// An implementation of [MidtransPluginPlatform] that uses method channels.
class MethodChannelMidtransPlugin extends MidtransPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  static const methodChannel = MethodChannel('midtrans_plugin');

  @override
  Future<void> initialize(MidtransConfig config) async {
    try {
      final payload = {'config': config.toJson()};
      await methodChannel.invokeMethod('initialize', payload);

      methodChannel.setMethodCallHandler((call) async {
        if (call.method == 'onTransactionResult') {
          try {
            final jsonData = Map<String, dynamic>.from(call.arguments);
            final result = MidtransTransactionResult.fromJson(jsonData);
            onTransactionResult.add(result);
          } catch (e) {
            throw MidtransFailure.unexpectedError(
              code: 'onTransactionResult',
              message: e.toString(),
            );
          }
        }
      });
    } on PlatformException catch (e) {
      throw MidtransFailure.unexpectedError(
        code: e.code,
        message: e.message,
      );
    } on MidtransFailure {
      rethrow;
    }
  }

  @override
  Future<void> checkout(MidtransCheckoutPayload payload) async {
    try {
      await methodChannel.invokeMethod('checkout', payload.toJson());
    } on PlatformException catch (e) {
      throw MidtransFailure.unexpectedError(
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Future<void> checkoutWithToken(String token) async {
    try {
      final payload = {'token': token};
      await methodChannel.invokeMethod('checkoutWithToken', payload);
    } on PlatformException catch (e) {
      throw MidtransFailure.unexpectedError(
        code: 'checkoutWithToken',
        message: e.toString(),
      );
    }
  }
}
