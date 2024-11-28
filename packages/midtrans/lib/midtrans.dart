import 'package:midtrans_platform_interface/midtrans_plugin.dart';

export 'package:midtrans_platform_interface/models/models.dart';

class Midtrans {
  static Midtrans? _instance;
  static late final MidtransConfig _config;

  Midtrans._internal(MidtransConfig config) {
    _config = config;
  }

  static Future<void> initialize(MidtransConfig config) async {
    try {
      _instance = Midtrans._internal(config);
      await instance.platform.initialize(config);
    } catch (e) {
      throw const MidtransFailure.initializeFailed();
    }
  }

  static Midtrans get instance {
    if (_instance == null) {
      throw Exception(
          'Midtrans is not initialized. Please call Midtrans.initialize() before using it.');
    }
    return _instance!;
  }

  MidtransPluginPlatform get platform {
    return MidtransPluginPlatform.instance;
  }

  static MidtransConfig get config => _config;

  Future<void> checkout(String snapToken) async {
    try {
      await platform.checkout(snapToken);
    } on MidtransFailure {
      rethrow;
    } catch (e) {
      throw const MidtransFailure.unexpectedError();
    }
  }
}
