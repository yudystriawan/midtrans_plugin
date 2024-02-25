typedef TransactionResultCallback = void Function(TransactionResult result);

class TransactionResult {
  final String? statusMessage;
  final String? paymentType;
  final String? transactionStatus;
  final String? transactionId;
  final String? orderId;
  final bool isCanceled;
  final bool isFailed;

  TransactionResult({
    this.statusMessage,
    this.paymentType,
    this.transactionStatus,
    this.transactionId,
    this.orderId,
    this.isCanceled = false,
    this.isFailed = false,
  });

  factory TransactionResult.fromJson(Map<String, dynamic> json) {
    return TransactionResult(
      statusMessage: json['statusMessage'],
      paymentType: json['paymentType'],
      transactionStatus: json['transactionStatus'],
      transactionId: json['transactionId'],
      orderId: json['orderId'],
      isCanceled: json['isCanceled'] ?? false,
      isFailed: json['isFailed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'statusMessage': statusMessage,
        'paymentType': paymentType,
        'transactionStatus': transactionStatus,
        'transactionId': transactionId,
        'orderId': orderId,
        'isCanceled': isCanceled,
        'isFailed': isFailed,
      };

  @override
  String toString() {
    return 'TransactionResult('
        'message: $statusMessage, '
        'paymentType: $paymentType, '
        'status: $transactionStatus, '
        'transactionId: $transactionId, '
        'orderId: $orderId, '
        'isCanceled: $isCanceled, '
        'isFailed: $isFailed)';
  }
}
