
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class NoOrderWidget extends StatelessWidget {
  const NoOrderWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: ScreenUtil.getInstance().getAdapterSize(20)),
        SvgPicture.asset('assets/icon/svg/ic_no_order.svg'),
        Text(title,
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(18),
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Text(
          'Hiện tại bạn không có đơn hàng mới.',
          style: TextStyle(
              fontSize: ScreenUtil.getInstance().getAdapterSize(14)),
        )
      ],
    );
  }
}
