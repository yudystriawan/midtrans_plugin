import 'package:midtrans_plugin/models/midtrans_config.dart';

import 'midtrans_plugin_platform_interface.dart';

class MidtransPlugin {
  MidtransPlugin._();

  static MidtransPlugin? _instance;

  static MidtransPlugin get instance {
    if (_instance == null) {
      throw UnimplementedError('MidtransPlugin instance not initialized yet!');
    }

    return _instance!;
  }

  static Future<void> initialize(MidtransConfig config) async {
    if (_instance != null) return;

    final result = await MidtransPluginPlatform.instance.initialize(config);

    if (result ?? false) {
      _instance = MidtransPlugin._();
    }

    return;
  }

  Future<void> startPayment() {
    return MidtransPluginPlatform.instance.startPayment();
  }
}
