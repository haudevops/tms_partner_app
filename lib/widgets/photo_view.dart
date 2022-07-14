import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class PhotoView extends StatelessWidget {
  const PhotoView({Key? key, required this.arguments}) : super(key: key);

  final ScreenArguments arguments;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        width: ScreenUtil.getInstance().screenWidth,
        height: ScreenUtil.getInstance().screenHeight,
        color: AppColor.colorItemDarkWhite,
        child: InteractiveViewer(
            minScale: 0.1,
            maxScale: 3.6,
            child: Image.file(
              File(arguments.arg1),
              fit: BoxFit.contain
            )),
      ),
    );
  }
}
