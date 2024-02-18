
import 'midtrans_plugin_platform_interface.dart';

class MidtransPlugin {
  Future<String?> getPlatformVersion() {
    return MidtransPluginPlatform.instance.getPlatformVersion();
  }
}
