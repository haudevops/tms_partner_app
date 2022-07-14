

import 'package:tms_partner_app/utils/prefs_util.dart';

class PushLocationResponse {
  PushLocationResponse(
      {this.timestamp,
      this.nextInterval,
      this.accuracy,
      this.errorCode,
      this.message});

  factory PushLocationResponse.fromJson(Map<String, dynamic> json) {
    return PushLocationResponse(
        timestamp: checkDouble(json['timestamp']),
        nextInterval: json['nextInterval'],
        accuracy: json['accuracy']);
  }

  double? timestamp;
  int? nextInterval;
  String? accuracy;
  String? message;
  int? errorCode;
}
