import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

Widget getLoadingWidget() {
  return Container(
    height: ScreenUtil.getInstance().screenHeight,
    width: ScreenUtil.getInstance().screenWidth,
    color: Colors.black26,
    // child: Center(
    //   child: SizedBox(
    //     width: 150,
    //     height: 150,
    //     child: Image.asset('assets/images/delivery.gif',fit: BoxFit.fill),
    //   )
    // ),
    child: Container()
  );
}