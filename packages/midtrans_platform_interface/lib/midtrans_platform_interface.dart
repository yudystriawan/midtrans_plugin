
import 'midtrans_platform_interface_platform_interface.dart';

class MidtransPlatformInterface {
  Future<String?> getPlatformVersion() {
    return MidtransPlatformInterfacePlatform.instance.getPlatformVersion();
  }
}
