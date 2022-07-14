import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class SplashPage extends BasePage {
  static const routeName = '/SplashPage';

  const SplashPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage, BaseBloc>{
  // late AnimationController _controller;
  // late SplashBloc _bloc;



  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg_login.png',
            width: ScreenUtil.getInstance().screenWidth,
            height: ScreenUtil.getInstance().screenHeight,
            fit: BoxFit.cover,
          ),
          Center(
            child: Image.asset(
              'assets/images/logo_supra_white.png',
              width: 300,
              height: 300,
            ),
          )
        ],
      ),
    );
  }

  @override
  void onCreate() {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    //
    // _controller = AnimationController(vsync: this);

    // _bloc = getBloc();
    Future.delayed(const Duration(seconds: 2), () => {
      Navigator.pushNamed(context, LoginPage.routeName)
    });
  }

  @override
  void onDestroy() {
    // _controller.dispose();
  }
}
