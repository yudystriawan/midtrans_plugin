struct ItemDetails {
  let id: String?
  let price: NSNumber
  let quantity: NSNumber
  let name: String
  let brand: String?
  let category: String?
  let merchantName: String?
  let url: String?
  
  init(dictionary: [String: Any]) {
    id = dictionary["id"] as? String
    price = dictionary["price"] as! NSNumber
    quantity = dictionary["quantity"] as! NSNumber
    name = dictionary["name"] as! String
    brand = dictionary["brand"] as? String
    category = dictionary["category"] as? String
    merchantName = dictionary["merchantName"] as? String
    url = dictionary["url"] as? String
  }
}
