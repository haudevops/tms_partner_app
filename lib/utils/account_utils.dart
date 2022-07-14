

import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/utils/prefs_const.dart';
import 'package:tms_partner_app/utils/prefs_util.dart';

class AccountUtil {
  AccountUtil._internal();

  static final AccountUtil instance = AccountUtil._internal();

  void saveToken(String? token) {
    PrefsUtil.putString(PrefsCache.KEY_ACCESS_TOKEN, token ?? '');
  }

  String? getToken() {
    return PrefsUtil.getString(PrefsCache.KEY_ACCESS_TOKEN);
  }

  void updateUserData(ProfileModel? profileModel) {
    if (profileModel != null) {
      PrefsUtil.putObject(PrefsCache.USER_DATA, profileModel);
    }
  }

  ProfileModel? getUserData() {
    return PrefsUtil.getObj<ProfileModel>(
        PrefsCache.USER_DATA, (v) => ProfileModel.fromJson(v));
  }

  void updateAppSetting(AppSettingModel? appSettingModel){
    if (appSettingModel != null) {
      PrefsUtil.putObject(PrefsCache.DATA_SETTING, appSettingModel);
    }
  }

  AppSettingModel? getAppSetting(){
    return PrefsUtil.getObj<AppSettingModel>(
        PrefsCache.DATA_SETTING, (v) => AppSettingModel.fromJson(v));
  }
}
