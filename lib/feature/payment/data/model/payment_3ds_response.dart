class Payment3dsResponse {
  final int transactionId;
  final String paReq;
  final String acsUrl;
  final bool iFrameIsAllowed;
  final String threeDsCallbackId;

  Payment3dsResponse({
    required this.transactionId,
    required this.paReq,
    required this.acsUrl,
    required this.iFrameIsAllowed,
    required this.threeDsCallbackId,
  });

  factory Payment3dsResponse.fromJson(Map<String, dynamic> data) {
    final json = data['data'];
    return Payment3dsResponse(
      transactionId: json['TransactionId'],
      paReq: json['PaReq'],
      acsUrl: json['AcsUrl'],
      iFrameIsAllowed: json['IFrameIsAllowed'],
      threeDsCallbackId: json['ThreeDsCallbackId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TransactionId': transactionId,
      'PaReq': paReq,
      'AcsUrl': acsUrl,
      'IFrameIsAllowed': iFrameIsAllowed,
      'ThreeDsCallbackId': threeDsCallbackId,
    };
  }
}
