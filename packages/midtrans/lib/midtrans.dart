import 'package:midtrans_platform_interface/midtrans_plugin.dart';

export 'package:midtrans_platform_interface/models/models.dart';

class Midtrans {
  static MidtransPluginPlatform? _platform;
  static late final MidtransConfig _config;

  Midtrans._internal();

  static Future<void> initialize(MidtransConfig config) async {
    try {
      _platform = MidtransPluginPlatform.instance;
      _config = config;

      await _platform!.initialize(config);
    } catch (e) {
      throw const MidtransFailure.initializeFailed();
    }
  }

  static MidtransPluginPlatform get platform {
    if (_platform == null) {
      throw const MidtransFailure.unexpectedError(
        message:
            'Midtrans is not initialized. Call Midtrans.initialize() first.',
      );
    }

    return _platform!;
  }

  static MidtransConfig get config => _config;
}
