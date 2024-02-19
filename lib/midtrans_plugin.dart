import 'midtrans_plugin_platform_interface.dart';

class MidtransPlugin {
  Future<String?> getPlatformVersion() {
    return MidtransPluginPlatform.instance.getPlatformVersion();
  }

  Future<bool?> initialize() {
    return MidtransPluginPlatform.instance.initialize();
  }

  Future<void> startPayment() {
    return MidtransPluginPlatform.instance.startPayment();
  }
}
