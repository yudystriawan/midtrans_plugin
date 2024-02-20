typedef TransactionResultCallback = void Function(TransactionResult result);

class TransactionResult {
  final String? message;
  final String? paymentType;
  final String? status;
  final String? transactionId;

  TransactionResult({
    this.message,
    this.paymentType,
    this.status,
    this.transactionId,
  });

  factory TransactionResult.fromJson(Map<String, dynamic> json) {
    return TransactionResult(
      message: json['message'],
      paymentType: json['paymentType'],
      status: json['status'],
      transactionId: json['transactionId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'paymentType': paymentType,
        'status': status,
        'transactionId': transactionId,
      };

  @override
  String toString() {
    return 'TransactionResult(message: $message, paymentType: $paymentType, status: $status, transactionId: $transactionId)';
  }
}
