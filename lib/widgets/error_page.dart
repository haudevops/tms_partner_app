
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenUtil.getInstance().screenWidth,
        height: ScreenUtil.getInstance().screenHeight,
        child: Column(
          children: [
            SizedBox(height: ScreenUtil.getInstance().screenHeight * 0.3),
            SvgPicture.asset('assets/icon/svg/ic_no_order.svg'),
            Text('Đã có lỗi xảy ra,',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(18),
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(
              'Vui lòng thử lại sau.',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(14)),
            )
          ],
        ),
      ),
    );
  }
}
