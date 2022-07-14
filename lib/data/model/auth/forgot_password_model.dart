class LoginOTPModel{
  LoginOTPModel({required this.message, required this.errorCode, this.phone});

  String? phone;
  String message;
  int errorCode;
}