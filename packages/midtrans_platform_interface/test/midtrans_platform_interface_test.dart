import 'package:flutter_test/flutter_test.dart';
import 'package:midtrans_platform_interface/midtrans_platform_interface.dart';
import 'package:midtrans_platform_interface/midtrans_platform_interface_platform_interface.dart';
import 'package:midtrans_platform_interface/midtrans_platform_interface_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMidtransPlatformInterfacePlatform
    with MockPlatformInterfaceMixin
    implements MidtransPlatformInterfacePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MidtransPlatformInterfacePlatform initialPlatform = MidtransPlatformInterfacePlatform.instance;

  test('$MethodChannelMidtransPlatformInterface is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMidtransPlatformInterface>());
  });

  test('getPlatformVersion', () async {
    MidtransPlatformInterface midtransPlatformInterfacePlugin = MidtransPlatformInterface();
    MockMidtransPlatformInterfacePlatform fakePlatform = MockMidtransPlatformInterfacePlatform();
    MidtransPlatformInterfacePlatform.instance = fakePlatform;

    expect(await midtransPlatformInterfacePlugin.getPlatformVersion(), '42');
  });
}
