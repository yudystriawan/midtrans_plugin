import 'package:midtrans_plugin/models/midtrans_config.dart';
import 'package:midtrans_plugin/models/midtrans_payload.dart';
import 'package:midtrans_plugin/models/transaction_result.dart';

import 'midtrans_plugin_platform_interface.dart';

class MidtransPlugin {
  MidtransPlugin._();

  static MidtransPluginPlatform? _delegatePackingProperty;

  static MidtransPluginPlatform get _delegate {
    return _delegatePackingProperty ??= MidtransPluginPlatform.instance;
  }

  static MidtransPlugin get instance {
    return MidtransPlugin._instanceFor();
  }

  factory MidtransPlugin._instanceFor() {
    final newInstance = MidtransPlugin._();
    return newInstance;
  }

  static Stream<TransactionResult> get onTransactionResult =>
      MidtransPluginPlatform.onTransactionResult.stream;

  Future<bool?> initialize(MidtransConfig config) {
    return _delegate.initialize(config);
  }

  bool get isInitialized => _delegate.isInitialized;

  Future<void> startPayment(MidtransPayload payload) async {
    return _delegate.startPayment(payload);
  }
}
