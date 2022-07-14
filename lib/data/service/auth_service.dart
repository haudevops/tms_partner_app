

import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/base/base_service.dart';
import 'package:tms_partner_app/data/api/patch_api.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/utils/constants.dart';

import '../../base/base_response.dart';

class AuthService {
  AuthService._internal();

  static final AuthService instance = AuthService._internal();

  final _baseService = BaseService();

  Future<LoginResponse> login(
      String? fcmToken, String phone, String password, String? uuid) async {
    final BaseResponse<Map<String, dynamic>> response = await _baseService
        .post<Map<String, dynamic>>(Apis.patchLogin, params: {
      'fcmToken': fcmToken,
      'phone': phone,
      'password': password,
      'uuid': uuid
    });

    if (response.errorCode == Constants.ERROR_CODE) {
      return LoginResponse(
          errorCode: response.errorCode, message: response.message);
    }

    return LoginResponse.fromJson(response.data!);
  }

  Future<ProfileModel> getInfoUser() async {
    final BaseResponse<Map<String, dynamic>> response =
        await _baseService.get<Map<String, dynamic>>(Apis.patchGetUserInfo);

    if (response.errorCode == Constants.ERROR_CODE) {
      return ProfileModel(
          errorCode: response.errorCode, message: response.message);
    }

    return ProfileModel.fromJson(response.data!);
  }

  Future<PasswordModel> changePassword(
      String currentPassword, String password, String rePassword) async {
    final BaseResponse<Map<String, dynamic>> response = await _baseService
        .put<Map<String, dynamic>>(Apis.patchChangePassword, params: {
      'currentPassword': currentPassword,
      'password': password,
      'rePassword': rePassword
    });

    return PasswordModel(
        errorCode: response.errorCode, message: response.message);
  }

  Future<LoginResponse> submitPhoneNumber(String phone) async {
    final BaseResponse<Map<String, dynamic>> response = await _baseService
        .post<Map<String, dynamic>>(Apis.patchEnterPhone, params: {
      'phone': phone,
    });

    return LoginResponse(
        errorCode: response.errorCode, message: response.message);
  }

  Future<LoginResponse> verifyOTP(
      String? opt, String phone, String? fcmToken, String? uuid) async {
    final BaseResponse<Map<String, dynamic>> response = await _baseService
        .post<Map<String, dynamic>>(Apis.patchVerifyOTP, params: {
      'OTP': opt,
      'fcmToken': fcmToken,
      'phone': phone,
      'uuid': uuid
    });

    if (response.errorCode == Constants.ERROR_CODE) {
      return LoginResponse(
          errorCode: response.errorCode, message: response.message);
    }

    return LoginResponse.fromJson(response.data!);
  }

  Future<AppSettingModel> getAppSetting() async {
    final BaseResponse<Map<String, dynamic>> response =
        await _baseService.get<Map<String, dynamic>>(Apis.patchGetAppSettings);

    if (response.errorCode == Constants.ERROR_CODE) {
      return AppSettingModel(
          errorCode: response.errorCode, message: response.message);
    }

    return AppSettingModel.fromJson(response.data!);
  }
}
