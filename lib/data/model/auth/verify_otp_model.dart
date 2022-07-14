class VerifyOTPModel {
  VerifyOTPModel(
      {this.otp,
      this.fcmToken,
      this.phone,
      this.uuid,
      this.message,
      this.errorCode});

  factory VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    return VerifyOTPModel(
      otp: json['OTP'],
      fcmToken: json['fcmToken'],
      phone: json['phone'],
      uuid: json['uuid'],
      message: json['message'],
      errorCode: 0,
    );
  }

  String? otp;
  String? fcmToken;
  String? phone;
  String? uuid;
  String? message;
  int? errorCode;
}
