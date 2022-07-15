
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/open_settings/open_settings.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class DialogInternetConnect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: _bodyWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/image/img_no_network_connection.png'),
        const SizedBox(height: 10),
        Text(
          'Supra không nhận được phản hồi từ bạn !Hãy kiểm tra kết nối mạng',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil().getAdapterSize(16), color: Colors.black26),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColor.colorPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              OpenSettings.openWIFISetting();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Đến cài đặt'.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
