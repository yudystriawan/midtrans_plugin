import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'midtrans_platform_interface_platform_interface.dart';

/// An implementation of [MidtransPlatformInterfacePlatform] that uses method channels.
class MethodChannelMidtransPlatformInterface extends MidtransPlatformInterfacePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('midtrans_platform_interface');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
