import Flutter
import UIKit

public class MidtransIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "midtrans_plugin", binaryMessenger: registrar.messenger())
    let instance = MidtransIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "initialize":
      initialize(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  func initialize(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
  }
}
