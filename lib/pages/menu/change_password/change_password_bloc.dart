
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/data/service/auth_service.dart';
import 'package:tms_partner_app/utils/common_utils/prefs_util.dart';
import 'package:tms_partner_app/utils/logs/logger.dart';

import '../../pages.dart';

class ChangePasswordBloc extends BaseBloc {
  final _changePasswordController = BehaviorSubject<PasswordModel>();
  late BuildContext _context;

  Stream<PasswordModel> get changePasswordStream =>
      _changePasswordController.stream;

  @override
  void dispose() {
    _changePasswordController.close();
  }

  @override
  void onCreate(BuildContext context) {
    _context = context;
  }

  Future<void> changePassword(
      String currentPassword, String password, String rePassword) async {
    showLoading();
    await AuthService.instance
        .changePassword(currentPassword, password, rePassword)
        .then((value) {
      if (value.errorCode == 0) {
        PrefsUtil.clear();
        Navigator.pushReplacementNamed(_context, LoginPage.routeName);
      }
      showMsg(value.message);
      hiddenLoading();
    }).catchError((error) {
      hiddenLoading();
      DebugLog.show('change password error: ${error.toString()}');
    });
  }
}
