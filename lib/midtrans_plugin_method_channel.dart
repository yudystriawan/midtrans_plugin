import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'midtrans_plugin_platform_interface.dart';

/// An implementation of [MidtransPluginPlatform] that uses method channels.
class MethodChannelMidtransPlugin extends MidtransPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('midtrans_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
