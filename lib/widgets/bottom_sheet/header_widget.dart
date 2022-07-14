
import 'package:flutter/material.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

Widget headerWidget({required BuildContext context, required String title}) {
  return Container(
    width: ScreenUtil.getInstance().screenWidth,
    height: ScreenUtil.getInstance().getAdapterSize(40),
    padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil.getInstance().getAdapterSize(16)),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close)),
        ),
        Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(16)),
          ),
        ),
      ],
    ),
  );
}
