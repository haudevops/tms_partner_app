import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/data/service/auth_service.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/utils/account_utils.dart';
import 'package:tms_partner_app/utils/common_utils/date_util.dart';
import 'package:tms_partner_app/utils/constants.dart';
import 'package:tms_partner_app/utils/fcm_token_id.dart';
import 'package:tms_partner_app/utils/logs/logger.dart';
import 'package:tms_partner_app/utils/prefs_const.dart';
import 'package:tms_partner_app/utils/prefs_util.dart';

class LoginBloc extends BaseBloc {

  Future<void> login(String phone, String password) async {
    showLoading();
    String? fcmToken = await FCMGetTokenID.instance.getToken();
    String? uuid = await FCMGetTokenID.instance.getId();

    await AuthService.instance
        .login(fcmToken, phone, password, uuid)
        .then((value) {
      if (value.errorCode != Constants.ERROR_CODE) {
        AccountUtil.instance.saveToken(value.token);
        AccountUtil.instance.updateUserData(value.profile);
        PrefsUtil.putBool(PrefsCache.IS_LOGIN, true);
        // Navigator.pushReplacementNamed(_context, NavigationPage.routeName);
        _getAppSetting();
      } else {
        showMsg(
            value.message ?? S.current.something_went_wrong_please_try_again);
      }
      // Navigator.pushReplacementNamed(_context, NavigationPage.routeName);
      hiddenLoading();
    }).catchError((error) {
      hiddenLoading();
      DebugLog.show('login error: ${error.toString()}');
    });
  }

  Future<void> _getAppSetting() async {
    await AuthService.instance.getAppSetting().then((value) {
      if (value.errorCode != Constants.ERROR_CODE) {
        _onGetSettingSuccess(value);
      } else {
        showMsg(
            value.message ?? S.current.something_went_wrong_please_try_again);
      }
    }).catchError((error) {
      DebugLog.show('getAppSetting error: ${error.toString()}');
    });
  }

  void _onGetSettingSuccess(AppSettingModel settingModel) {
    AccountUtil.instance.updateAppSetting(settingModel);
    PrefsUtil.putInt(PrefsCache.LAST_GET_SETTING_TIME, DateUtil.getNowDateMs());
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void onCreate(BuildContext context) {
    // TODO: implement onCreate
  }
}
