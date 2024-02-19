import 'package:flutter_test/flutter_test.dart';
import 'package:midtrans_plugin/midtrans_plugin.dart';
import 'package:midtrans_plugin/midtrans_plugin_method_channel.dart';
import 'package:midtrans_plugin/midtrans_plugin_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMidtransPluginPlatform
    with MockPlatformInterfaceMixin
    implements MidtransPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<void> startPayment() {
    // TODO: implement startPayment
    throw UnimplementedError();
  }
}

void main() {
  final MidtransPluginPlatform initialPlatform =
      MidtransPluginPlatform.instance;

  test('$MethodChannelMidtransPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMidtransPlugin>());
  });

  test('getPlatformVersion', () async {
    MidtransPlugin midtransPlugin = MidtransPlugin();
    MockMidtransPluginPlatform fakePlatform = MockMidtransPluginPlatform();
    MidtransPluginPlatform.instance = fakePlatform;

    expect(await midtransPlugin.getPlatformVersion(), '42');
  });
}
