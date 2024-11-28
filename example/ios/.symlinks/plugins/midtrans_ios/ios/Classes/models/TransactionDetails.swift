struct TransactionDetails {
  let orderId: String
  let grossAmount: NSNumber
  
  init(dictionary: [String: Any]) {
    orderId = dictionary["orderId"] as! String
    grossAmount = dictionary["grossAmount"] as! NSNumber
  }
}
