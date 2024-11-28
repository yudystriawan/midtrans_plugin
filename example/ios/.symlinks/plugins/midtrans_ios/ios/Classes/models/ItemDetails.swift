struct ItemDetails {
  let id: String?
  let price: Int
  let quantity: Int
  let name: String
  let brand: String?
  let category: String?
  let merchantName: String?
  let url: String?
  
  init(dictionary: [String: Any]) {
    id = dictionary["id"] as? String
    price = dictionary["price"] as! Int
    quantity = dictionary["quantity"] as! Int
    name = dictionary["name"] as! String
    brand = dictionary["brand"] as? String
    category = dictionary["category"] as? String
    merchantName = dictionary["merchant_name"] as? String
    url = dictionary["url"] as? String
  }
}
