import 'dart:async';

import 'package:midtrans_platform_interface/models/models.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'midtrans_method_channel.dart';

abstract class MidtransPluginPlatform extends PlatformInterface {
  /// Constructs a MidtransPluginPlatform.
  MidtransPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MidtransPluginPlatform _instance = MethodChannelMidtransPlugin();

  /// The default instance of [MidtransPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMidtransPlugin].
  static MidtransPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MidtransPluginPlatform] when
  /// they register themselves.
  static set instance(MidtransPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  final StreamController<MidtransTransactionResult> onTransactionResult =
      StreamController<MidtransTransactionResult>.broadcast();

  Future<void> initialize(MidtransConfig config) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<void> checkout(MidtransCheckoutPayload payload) {
    throw UnimplementedError('checkout() has not been implemented.');
  }

  Future<void> checkoutWithToken(String token) {
    throw UnimplementedError('checkoutWithToken() has not been implemented.');
  }
}
