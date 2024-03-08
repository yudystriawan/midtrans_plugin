// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   group('MethodChannelMidtransPlugin', () {
//     const MethodChannel channel = MethodChannel('midtrans_plugin');
//     late MethodChannelMidtransPlugin plugin;

//     setUp(() {
//       plugin = MethodChannelMidtransPlugin();
//       TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
//           .setMockMethodCallHandler(
//         channel,
//         (methodCall) async {
//           switch (methodCall.method) {
//             case 'initialize':
//               return true;
//             case 'startPayment':
//               return null;
//             default:
//               throw PlatformException(
//                 code: 'Unimplemented',
//                 message: 'Method not implemented on channel',
//               );
//           }
//         },
//       );
//     });

//     tearDown(() {
//       TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
//           .setMockMethodCallHandler(
//         channel,
//         null,
//       );
//     });

//     test('Initialize MidtransPlugin', () async {
//       final config = MidtransConfig(
//         merchantClientKey: 'YOUR_CLIENT_KEY',
//         merchantUrl: 'YOUR_MERCHANT_BASE_URL',
//       );

//       final result = await plugin.initialize(config);

//       expect(result, isTrue);
//     });

//     test('Start Payment', () async {
//       final payload = MidtransPayload(
//         transactionDetails: TransactionDetails(
//           orderId: 'ORDER_ID',
//           grossAmount: 10000,
//         ),
//         itemDetails: [
//           ItemDetail(id: '1', price: 10000, quantity: 1, name: 'Item')
//         ],
//       );

//       await plugin.startPayment(payload);

//       // No assertion needed, just verifying that it runs without error
//     });
//   });
// }

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:midtrans_plugin/midtrans_plugin_method_channel.dart';
import 'package:midtrans_plugin/midtrans_plugin_platform_interface.dart';
import 'package:midtrans_plugin/models/midtrans_config.dart';
import 'package:midtrans_plugin/models/midtrans_payload.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MidtransPluginPlatform midtransPluginPlatform;

  final config = MidtransConfig(
    merchantClientKey: 'YOUR_CLIENT_KEY',
    merchantUrl: 'YOUR_MERCHANT_BASE_URL',
  );

  final payload = MidtransPayload(
    transactionDetails: TransactionDetails(
      orderId: 'ORDER_ID',
      grossAmount: 10000,
    ),
    itemDetails: [ItemDetail(id: '1', price: 10000, quantity: 1, name: 'Item')],
  );

  final List<MethodCall> log = <MethodCall>[];

  group('$MethodChannelMidtransPlugin()', () {
    setUpAll(() {
      handleMethodCall((call) async {
        log.add(call);

        switch (call.method) {
          case 'initialize':
            return true;
          case 'startPayment':
            return null;
          default:
        }
      });
    });

    setUp(() {
      log.clear();
      midtransPluginPlatform = MethodChannelMidtransPlugin();
    });

    test('$MethodChannelMidtransPlugin is the default instance', () {
      expect(
        MidtransPluginPlatform.instance,
        isA<MethodChannelMidtransPlugin>(),
      );
    });

    test('Cannot be implemented with `implements`', () {
      expect(() {
        MidtransPluginPlatform.instance = MidtransPluginPlatformImpl();
      }, throwsAssertionError);
    });

    test('Can be extended', () {
      MidtransPluginPlatform.instance = MidtransPluginPlatformExtends();
    });

    test('Can be mocked with `implements`', () {
      final MidtransPluginPlatform mock = MockMidtransPLuginPlatform();
      MidtransPluginPlatform.instance = mock;
    });

    test('initialize', () async {
      await midtransPluginPlatform.initialize(config);

      expect(log, <Matcher>[
        isMethodCall('initialize', arguments: config.toJson()),
      ]);
    });

    test('startPayment', () async {
      await midtransPluginPlatform.startPayment(payload);

      expect(log, <Matcher>[
        isMethodCall('startPayment', arguments: payload.toJson()),
      ]);
    });
  });
}

class MidtransPluginPlatformImpl extends Mock
    implements MidtransPluginPlatform {}

class MockMidtransPLuginPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements MidtransPluginPlatform {}

class MidtransPluginPlatformExtends extends MidtransPluginPlatform {}

class TestMethodChannelMidtransPlugin extends MethodChannelMidtransPlugin {
  TestMethodChannelMidtransPlugin();
}

typedef MethodCallCallback = dynamic Function(MethodCall methodCall);
typedef Callback = Function(MethodCall call);

void handleMethodCall(MethodCallCallback methodCallCallback) =>
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(MethodChannelMidtransPlugin.channel,
            (call) async {
      return await methodCallCallback(call);
    });
