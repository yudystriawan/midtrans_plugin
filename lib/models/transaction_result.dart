/// Callback function signature for transaction result.
///
/// This callback function is typically invoked after a transaction has been processed,
/// providing information about the transaction result.
typedef TransactionResultCallback = void Function(TransactionResult result);

/// Represents the result of a transaction.
class TransactionResult {
  /// The status message of the transaction.
  final String? statusMessage;

  /// The type of payment used in the transaction.
  final String? paymentType;

  /// The status of the transaction.
  final String? transactionStatus;

  /// The ID associated with the transaction.
  final String? transactionId;

  /// The order ID associated with the transaction.
  final String? orderId;

  /// Indicates whether the transaction is canceled.
  final bool isCanceled;

  /// Indicates whether the transaction has failed.
  final bool isFailed;

  /// Creates a new instance of [TransactionResult].
  ///
  /// [statusMessage] is the status message of the transaction.
  /// [paymentType] is the type of payment used in the transaction.
  /// [transactionStatus] is the status of the transaction.
  /// [transactionId] is the ID associated with the transaction.
  /// [orderId] is the order ID associated with the transaction.
  /// [isCanceled] indicates whether the transaction is canceled. Default is `false`.
  /// [isFailed] indicates whether the transaction has failed. Default is `false`.
  TransactionResult({
    this.statusMessage,
    this.paymentType,
    this.transactionStatus,
    this.transactionId,
    this.orderId,
    this.isCanceled = false,
    this.isFailed = false,
  });

  /// Creates a [TransactionResult] instance from a JSON map.
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

  /// Converts the transaction result to a JSON representation.
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
