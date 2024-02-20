class MidtransConfig {
  final String merchantClientKey;
  final String merchantUrl;
  final bool enableLog;

  MidtransConfig({
    required this.merchantClientKey,
    required this.merchantUrl,
    this.enableLog = true,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'merchantClientKey': merchantClientKey});
    result.addAll({'merchantUrl': merchantUrl});
    result.addAll({'enableLog': enableLog});

    return result;
  }

  factory MidtransConfig.fromJson(Map<String, dynamic> json) {
    return MidtransConfig(
      merchantClientKey: json['merchantClientKey'] ?? '',
      merchantUrl: json['merchantUrl'] ?? '',
      enableLog: json['enableLog'],
    );
  }
}
