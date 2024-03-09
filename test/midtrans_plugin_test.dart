// import 'package:flutter_test/flutter_test.dart';
// import 'package:midtrans_plugin/midtrans_plugin.dart';
// import 'package:midtrans_plugin/midtrans_plugin_method_channel.dart';
// import 'package:midtrans_plugin/midtrans_plugin_platform_interface.dart';
// import 'package:midtrans_plugin/models/midtrans_config.dart';
// import 'package:midtrans_plugin/models/midtrans_payload.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockMidtransPluginPlatform
//     with MockPlatformInterfaceMixin
//     implements MidtransPluginPlatform {
//   // @override
//   // Future<String?> getPlatformVersion() => Future.value('42');

//   @override
//   Future<bool?> initialize(MidtransConfig config) {
//     return Future.value(true);
//   }

//   @override
//   Future<void> startPayment(MidtransPayload payload) async {
//     return;
//   }
// }

// void main() {
//   final MidtransPluginPlatform initialPlatform =
//       MidtransPluginPlatform.instance;

//   group(MidtransPlugin, () {
//     setUpAll(() {});

//     test('$MethodChannelMidtransPlugin is the default instance', () {
//       expect(initialPlatform, isInstanceOf<MethodChannelMidtransPlugin>());
//     });

//     test('.initialize()', () async {
//       final config = MidtransConfig(
//         merchantClientKey: 'YOUR_CLIENT_KEY',
//         merchantUrl: 'YOUR_MERCHANT_BASE_URL',
//       );
//       await MidtransPlugin.initialize(config);
//     });
//   });

//   // test('getPlatformVersion', () async {
//   //   MidtransPlugin midtransPlugin = MidtransPlugin.initialize(config);
//   //   MockMidtransPluginPlatform fakePlatform = MockMidtransPluginPlatform();
//   //   MidtransPluginPlatform.instance = fakePlatform;

//   //   MidtransPluginPlatform.instance

//   //   expect(await midtransPlugin.getPlatformVersion(), '42');
//   // });
// }

import 'package:flutter_test/flutter_test.dart';
import 'package:midtrans_plugin/midtrans_plugin.dart';
import 'package:midtrans_plugin/midtrans_plugin_platform_interface.dart';
import 'package:midtrans_plugin/models/midtrans_config.dart';
import 'package:midtrans_plugin/models/midtrans_payload.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMidtransPlugin extends Mock
    with MockPlatformInterfaceMixin
    implements MidtransPluginPlatform {
  MockMidtransPlugin() {
    TestMidtransPluginPlatform();
  }

  @override
  Future<bool?> initialize(MidtransConfig config) {
    return super.noSuchMethod(
      Invocation.getter(#initialize),
      returnValue: Future<bool?>.value(),
      returnValueForMissingStub: Future<bool?>.value(),
    );
  }

  @override
  Future<void> startPayment(MidtransPayload payload) {
    return super.noSuchMethod(
      Invocation.getter(#startPayment),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }
}

class TestMidtransPluginPlatform extends MidtransPluginPlatform {
  TestMidtransPluginPlatform() : super();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MidtransPlugin midtransPlugin;
  final mockMidtransPluginPlatform = MockMidtransPlugin();

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

  group('$MidtransPlugin', () {
    setUpAll(() {
      MidtransPluginPlatform.instance = mockMidtransPluginPlatform;
      midtransPlugin = MidtransPlugin.instance;
    });

    group('instance', () {
      test('returns an instance', () {
        expect(midtransPlugin, isA<MidtransPlugin>());
      });
    });

    group('initialize', () {
      test('verify delegate method is called with correct args', () async {
        when(mockMidtransPluginPlatform.initialize(config))
            .thenAnswer((_) => Future.value(true));

        final result = await MidtransPlugin.initialize(config);

        expect(result, isTrue);

        verify(mockMidtransPluginPlatform.initialize(config)).called(1);
      });
    });

    group('startPayment', () {
      test('verify delegate method is called with correct args', () async {
        when(mockMidtransPluginPlatform.startPayment(payload))
            .thenAnswer((_) => Future.value());

        await midtransPlugin.startPayment(payload);

        verify(mockMidtransPluginPlatform.startPayment(payload)).called(1);
      });
    });
  });
}
