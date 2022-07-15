import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/constants.dart';
import 'package:tms_partner_app/utils/prefs_const.dart';
import 'package:tms_partner_app/utils/prefs_util.dart';
import 'package:tms_partner_app/utils/providers/language_provider.dart';
import 'package:tms_partner_app/utils/providers/theme_provider.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class SettingPage extends BasePage {
  static const routeName = '/SettingPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _SettingPageState();
}

class _SettingPageState extends BasePageState<SettingPage> {
  bool _isThemeDark = false;
  late bool _checkLanguage;

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.menu_setting,
          style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil.getInstance().getAdapterSize(18)),
        ),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColor.colorWhiteDark,
        centerTitle: true,
      ),
      backgroundColor: AppColor.colorDarkGray,
      body: Padding(
        padding:
            EdgeInsets.only(top: ScreenUtil.getInstance().getAdapterSize(20)),
        child: Column(
          children: [
            _itemSafeModeWidget(),
            Divider(
                color: Colors.grey,
                height: 0,
                indent: ScreenUtil.getInstance().getAdapterSize(75),
                endIndent: ScreenUtil.getInstance().getAdapterSize(35)),
            _showSheetLanguage(),
            SizedBox(
              height: ScreenUtil.getInstance().getAdapterSize(16),
            ),
            _itemChangePassword(),
          ],
        ),
      ),
    );
  }

  Widget _showSheetLanguage() {
    return Container(
      color: AppColor.colorWhiteDark,
      child: ListTile(
        title: Text(
          S.current.language,
          style: TextStyle(fontSize: ScreenUtil.getInstance().getSp(15)),
        ),
        leading: SvgPicture.asset(
          'assets/icon/svg/setting_ic_language.svg',
          width: ScreenUtil.getInstance().getAdapterSize(25),
          height: ScreenUtil.getInstance().getAdapterSize(25),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _checkLanguage ? 'English' : 'Vietnamese',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(15)),
            ),
            SizedBox(width: 10),
            Icon(Icons.chevron_right_rounded)
          ],
        ),
        onTap: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              builder: (context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: StatefulBuilder(
                    builder: (context, StateSetter state) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _headerWidget(),
                          _radioCheckLanguage(
                              'Vietnamese', _checkLanguage, false),
                          _radioCheckLanguage('English', _checkLanguage, true),
                        ],
                      );
                    },
                  ),
                );
              });
        },
      ),
    );
  }

  Widget _radioCheckLanguage(String language, bool value, bool groupValue) {
    final provider = Provider.of<LanguageProvider>(context, listen: false);
    return RadioListTile(
      title: Text(language),
      value: value,
      groupValue: groupValue,
      onChanged: (value) {
        _checkLanguage = !_checkLanguage;
        provider.changeLocale(
            _checkLanguage ? Constants.ENGLISH : Constants.VIETNAMESE);
      },
    );
  }

  Widget _headerWidget() {
    return Container(
      width: ScreenUtil.getInstance().screenWidth,
      height: ScreenUtil.getInstance().getAdapterSize(50),
      child: Stack(
        children: [
          Positioned(
            top: ScreenUtil.getInstance().getAdapterSize(20),
            left: ScreenUtil.getInstance().getAdapterSize(18),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close)),
          ),
          Center(
            child: Text(
              S.current.language,
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemSafeModeWidget() {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    return Container(
      color: AppColor.colorWhiteDark,
      child: SwitchListTile(
        title: Text(
          S.current.safe_mode,
          style:
              TextStyle(fontSize: ScreenUtil.getInstance().getAdapterSize(15)),
        ),
        value: _isThemeDark,
        onChanged: (bool value) {
          setState(() {
            _isThemeDark = !_isThemeDark;
            provider.toggleTheme(value);
          });
        },
        activeColor: Colors.green,
        secondary: SvgPicture.asset(
          'assets/icon/svg/setting_ic_battery.svg',
          width: ScreenUtil.getInstance().getAdapterSize(25),
          height: ScreenUtil.getInstance().getAdapterSize(25),
        ),
      ),
    );
  }

  Widget _itemChangePassword() {
    return Container(
      color: AppColor.colorWhiteDark,
      child: ListTile(
          leading: SvgPicture.asset(
            'assets/icon/svg/setting_ic_change_password.svg',
            width: ScreenUtil.getInstance().getAdapterSize(25),
            height: ScreenUtil.getInstance().getAdapterSize(25),
          ),
          title: Text(
            S.current.change_password_low,
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(15)),
          ),
          onTap: () {
            Navigator.pushNamed(context, ChangePasswordPage.routerName);
          },
          trailing: const Icon(Icons.chevron_right_rounded)),
    );
  }

  @override
  void onCreate() {
    String? languageLocal = PrefsUtil.getString(PrefsCache.LANGUAGE_CHANGE);
    _checkLanguage =
        (languageLocal != null && languageLocal == Constants.ENGLISH);
    // if(languageLocal != null && languageLocal == 'en'){
    //   _checkLanguage = true;
    // }else{
    //   _checkLanguage = false;
    // }
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
