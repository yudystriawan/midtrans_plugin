import Flutter
import UIKit
import MidtransKit

public class MidtransIosPlugin: NSObject, FlutterPlugin, MidtransUIPaymentViewControllerDelegate {
  public func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentPending result: MidtransTransactionResult!) {
    print("paymendPending result: \(String(describing: result))")
  }
  
  public func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentDeny result: MidtransTransactionResult!) {
    print("paymentDeny result: \(String(describing: result))")
  }
  
  public func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentSuccess result: MidtransTransactionResult!) {
    print("paymentSuccess result: \(String(describing: result))")
  }
  
  public func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentFailed error: (any Error)!) {
    print("paymentFailed error: \(String(describing: error))")
  }
  
  public func paymentViewController_paymentCanceled(_ viewController: MidtransUIPaymentViewController!) {
    print("paymentCanceled")
  }
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "midtrans_plugin", binaryMessenger: registrar.messenger())
    let instance = MidtransIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "initialize":
      initialize(call, result: result)
    case "checkout":
      checkout(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  var rootViewController: UIViewController? {
    return UIApplication.shared.keyWindow?.rootViewController;
  }
  
  func initialize(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print("initialize called")
    
    guard let arguments = call.arguments as? Dictionary<String, AnyObject>,
          let configArgs = arguments["config"] as? NSDictionary else {
      result(FlutterError.init(code: "invalid_arguments",
                               message: "config is required",
                               details: nil))
      return
    }
    
    let config = MidtransConfig(dictionary: configArgs)
    
    MidtransKit.MidtransConfig.shared().setClientKey(config?.clientKey, environment: config?.isProduction == true ? .production:.sandbox, merchantServerURL: config?.baseUrl)
    
    if config?.enableLog == true {
      MidtransNetworkLogger.shared().startLogging()
    }
    
    print("initialized")
    
    result(nil)
  }
  
  func checkout(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print("checkout called")
    
    let arguments = call.arguments as! Dictionary<String, AnyObject>
    
    guard let transactionDetailsArgs = arguments["transactionDetails"] as? Dictionary<String, AnyObject> else {
      result(FlutterError.init(code: "invalid_arguments", message: "transactionDetails is required", details: nil))
      return
    }
    let transactionDetailsPayload: TransactionDetails = TransactionDetails(dictionary: transactionDetailsArgs)
    let transactionDetails: MidtransTransactionDetails = MidtransTransactionDetails(orderID: transactionDetailsPayload.orderId, andGrossAmount: transactionDetailsPayload.grossAmount)
    
    let itemDetailsArgs = arguments["itemDetails"] as? [Dictionary<String, AnyObject>]
    let itemDetailsPayload: [ItemDetails]? = itemDetailsArgs?.compactMap{ ItemDetails(dictionary: $0) }
    let itemDetails: [MidtransItemDetail]? = itemDetailsPayload?.compactMap{ MidtransItemDetail(itemID: $0.id, name: $0.name, price: $0.price, quantity: $0.quantity) }
    
    MidtransMerchantClient.shared().requestTransactionToken(with: transactionDetails, itemDetails: itemDetails, customerDetails: nil) { (response, error) in
      if (response != nil) {
        let vc = MidtransUIPaymentViewController.init(token: response)
        vc?.paymentDelegate = self
        self.rootViewController?.present(vc!, animated: true, completion: nil)
      } else {
        result(FlutterError.init(code: "internal", message: error?.localizedDescription, details: nil))
      }
    }
  }
}
