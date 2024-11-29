struct MidtransConfig {
  let clientKey: String
  let baseUrl: String
  let isProduction: Bool
  let enableLog: Bool
  
  init?(dictionary: NSDictionary) {
      // Safely unwrap the values from the dictionary
      guard let clientKey = dictionary["clientKey"] as? String, !clientKey.isEmpty,
            let baseUrl = dictionary["baseUrl"] as? String, !baseUrl.isEmpty else {
          return nil // Return nil if any required value is missing or empty
      }
      
      // Assign the properties
      self.clientKey = clientKey
      self.baseUrl = baseUrl
      self.isProduction = dictionary["isProduction"] as? Bool ?? false
      self.enableLog = dictionary["enableLog"] as? Bool ?? false
  }
}
