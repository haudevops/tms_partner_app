
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/data/service/auth_service.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/utils/account_utils.dart';
import 'package:tms_partner_app/utils/constants.dart';
import 'package:tms_partner_app/utils/logs/logger.dart';

class MenuBloc extends BaseBloc {
  // final _getUserInfoController = BehaviorSubject<ProfileModel?>();
  // final _getVersionAppController = BehaviorSubject<String>();
  //
  // Stream<ProfileModel?> get userInfoStream => _getUserInfoController.stream;
  //
  // Stream<String> get versionAppStream => _getVersionAppController.stream;
  //
  // Future<void> getUserInfo() async {
  //   showLoading();
  //   // Get info user from API
  //   await AuthService.instance.getInfoUser().then((value) {
  //     if (value.errorCode != Constants.ERROR_CODE) {
  //       // Update UI
  //       _getUserInfoController.sink.add(value);
  //       // Save data to storage
  //       _updateDataLocal(value);
  //     } else {
  //       DebugLog.show(value.message);
  //     }
  //     hiddenLoading();
  //   }).catchError((error) {
  //     DebugLog.show('Menu bloc getInfoUser: ${error.toString()}');
  //     hiddenLoading();
  //   });
  // }
  //
  // Future<void> _getVersion() async {
  //   // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   // _getVersionAppController.sink.add(packageInfo.version);
  // }
  //
  // void _updateDataLocal(ProfileModel? profileModel) {
  //   AccountUtil.instance.updateUserData(profileModel);
  // }
  //
  // @override
  // void dispose() {
  //   _getUserInfoController.close();
  //   _getVersionAppController.close();
  // }
  //
  // @override
  // void onCreate(BuildContext context) {
  //   // Get info user from local
  //   _getUserInfoController.sink.add(AccountUtil.instance.getUserData());
  //   // Get info user from API
  //   getUserInfo();
  //   // get version app
  //   _getVersion();
  // }

  List<ItemSettingsModel> getItemsListOne() {
    return [
      ItemSettingsModel(
          id: Constants.ITEM_MENU_HISTORY,
          title: S.current.menu_history,
          image: 'assets/icon/svg/menu_ic_history.svg'),
      ItemSettingsModel(
          id: Constants.ITEM_MENU_STATISTICAL,
          title: S.current.menu_statistical,
          image: 'assets/icon/svg/menu_ic_statistical.svg'),
      ItemSettingsModel(
          id: Constants.ITEM_MENU_WALLET,
          title: S.current.menu_wallet,
          image: 'assets/icon/svg/menu_ic_wallet.svg'),
      ItemSettingsModel(
          id: Constants.ITEM_MENU_SHARE_CODE,
          title: S.current.menu_share_code,
          image: 'assets/icon/svg/menu_ic_share_code.svg')
    ];
  }

  List<ItemSettingsModel> getItemsListTwo() {
    return [
      ItemSettingsModel(
          id: Constants.ITEM_MENU_NEWS,
          title: S.current.menu_news,
          image: 'assets/icon/svg/menu_ic_news.svg'),
      ItemSettingsModel(
          id: Constants.ITEM_MENU_TERMS_POLICY,
          title: S.current.terms_policy,
          image: 'assets/icon/svg/menu_ic_term_policy.svg'),
      ItemSettingsModel(
          id: Constants.ITEM_MENU_HELP,
          title: S.current.menu_help,
          image: 'assets/icon/svg/menu_ic_help.svg'),
      ItemSettingsModel(
          id: Constants.ITEM_MENU_SETTING,
          title: S.current.menu_setting,
          image: 'assets/icon/svg/menu_ic_setting.svg')
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void onCreate(BuildContext context) {
    getItemsListOne();
    getItemsListTwo();
  }
}
