struct TransactionDetails {
  let orderId: String
  let grossAmount: NSNumber
  
  init(dictionary: [String: Any]) {
    orderId = dictionary["order_id"] as! String
    grossAmount = dictionary["gross_amount"] as! NSNumber
  }
}
