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
      await instance._platform.initialize(config);
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

  MidtransPluginPlatform get _platform {
    return MidtransPluginPlatform.instance;
  }

  static MidtransConfig get config => _config;

  Stream<MidtransTransactionResult> get onTransactionResult {
    return _platform.onTransactionResult.stream;
  }

  Future<void> checkout(MidtransCheckoutPayload payload) async {
    try {
      await _platform.checkout(payload);
    } on MidtransFailure {
      rethrow;
    } catch (e) {
      throw const MidtransFailure.unexpectedError();
    }
  }

  Future<void> checkoutWithToken(String token) async {
    try {
      await _platform.checkoutWithToken(token);
    } on MidtransFailure {
      rethrow;
    } catch (e) {
      throw const MidtransFailure.unexpectedError();
    }
  }
}
