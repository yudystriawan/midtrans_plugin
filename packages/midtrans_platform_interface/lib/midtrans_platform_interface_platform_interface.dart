import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'midtrans_platform_interface_method_channel.dart';

abstract class MidtransPlatformInterfacePlatform extends PlatformInterface {
  /// Constructs a MidtransPlatformInterfacePlatform.
  MidtransPlatformInterfacePlatform() : super(token: _token);

  static final Object _token = Object();

  static MidtransPlatformInterfacePlatform _instance = MethodChannelMidtransPlatformInterface();

  /// The default instance of [MidtransPlatformInterfacePlatform] to use.
  ///
  /// Defaults to [MethodChannelMidtransPlatformInterface].
  static MidtransPlatformInterfacePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MidtransPlatformInterfacePlatform] when
  /// they register themselves.
  static set instance(MidtransPlatformInterfacePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
