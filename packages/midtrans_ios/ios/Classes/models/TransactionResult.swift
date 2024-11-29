import MidtransKit

struct TransactionResult {
  let transactionId: String?
  let status: String?
  let paymentType: String?
  let message: String?
  let isCancelled: Bool
  let isFailed: Bool
  
  init(result: MidtransTransactionResult) {
    transactionId = result.transactionId
    status = result.transactionStatus
    paymentType = result.paymentType
    message = result.statusMessage
    isCancelled = false
    isFailed = false
  }
  
  init (error: (any Error)) {
    transactionId = nil
    status = nil
    paymentType = nil
    message = error.localizedDescription
    isCancelled = false
    isFailed = true
  }
  
  init(cancelled: Bool) {
    transactionId = nil
    status = nil
    paymentType = nil
    message = nil
    isCancelled = cancelled
    isFailed = false
  }
  
  
  
  func toJson() -> [String: Any] {
    var json: [String: Any] = [:]
    json["transactionId"] = transactionId
    json["status"] = status
    json["paymentType"] = paymentType
    json["message"] = message
    json["isCancelled"] = isCancelled
    json["isFailed"] = isFailed
    return json
  }
}
