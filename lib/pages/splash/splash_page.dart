import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

import '../../utils/common_utils/prefs_util.dart';
import '../../utils/prefs_const.dart';

class SplashPage extends BasePage<SplashBloc> {
  static const routeName = '/SplashPage';

  SplashPage() : super(bloc: SplashBloc());


  @override
  BasePageState<BasePage<BaseBloc>> getState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage> {
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
        isLogin ? NavigationPage.routeName : LoginPage.routeName, context, 0);
  }

  void startScreen(String route, BuildContext context, int indexPage) {
    Future.delayed(const Duration(seconds: 2),
        () => {Navigator.pushReplacementNamed(context, route, arguments: ScreenArguments(arg1: indexPage))});
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
