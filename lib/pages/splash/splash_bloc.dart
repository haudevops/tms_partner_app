//
// import 'package:flutter/material.dart';
// import 'package:tms_partner_app/base/base.dart';
// import 'package:tms_partner_app/utils/prefs_const.dart';
// import 'package:tms_partner_app/utils/prefs_util.dart';
//
// import '../pages.dart';
//
// class SplashBloc extends BaseBloc {
//   @override
//   void dispose() {}
//
//   @override
//   void onCreate(BuildContext context) {}
//
//   Future<void> checkLogin(BuildContext context) async {
//     final isLogin =
//         PrefsUtil.getBool(PrefsCache.IS_LOGIN, defValue: false) ?? false;
//     startScreen(
//         isLogin ? NavigationPage.routeName : LoginPage.routeName, context);
//   }
//
//   void startScreen(String route, BuildContext context) {
//     Navigator.pushReplacementNamed(context, route);
//   }
// }
