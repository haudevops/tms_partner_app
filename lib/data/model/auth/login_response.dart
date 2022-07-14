



import 'package:tms_partner_app/data/model/models.dart';

class LoginResponse {
  LoginResponse(
      {this.message,
      this.errorCode,
      this.token,
      this.refreshToken,
      this.profile});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: '',
      errorCode: 0,
      token: json['token'],
      refreshToken: json['refreshToken'],
      profile: json['profile'] != null
          ? ProfileModel.fromJson(json['profile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'errorCode': errorCode,
        'token': token,
        'refreshToken': refreshToken,
        'profile': profile?.toJson(),
      };

  String? message;
  int? errorCode;
  String? token;
  String? refreshToken;
  ProfileModel? profile;
}
