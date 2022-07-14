import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

import '../../utils/common_utils/prefs_util.dart';
import '../../utils/prefs_const.dart';

class SplashPage extends BasePage {
  static const routeName = '/SplashPage';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage, BaseBloc> {
  // late AnimationController _controller;
  // late SplashBloc _bloc;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: ScreenUtil.getInstance().screenWidth,
        height: ScreenUtil.getInstance().screenHeight,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/splash_screen.png',
              width: ScreenUtil.getInstance().screenWidth,
              height: ScreenUtil.getInstance().screenHeight,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkToken() async {
    final SharedPreferences prefs = await _prefs;
    final isLogin =
        prefs.getBool(PrefsCache.IS_LOGIN) ?? false;
    log('$isLogin');
    startScreen(
        isLogin ? NavigationPage.routeName : LoginPage.routeName, context);
  }

  void startScreen(String route, BuildContext context) {
    Future.delayed(const Duration(seconds: 2),
        () => {Navigator.pushReplacementNamed(context, route)});
  }

  @override
  void onCreate() {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    //
    // _controller = AnimationController(vsync: this);

    // _bloc = getBloc();
    _checkToken();
  }

  @override
  void onDestroy() {
    // _controller.dispose();
  }
}
