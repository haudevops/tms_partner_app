import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class DetailHelpPage extends BasePage {
  static const routeName = '/DetailHelpPage';
  final ScreenArguments data;

  DetailHelpPage({Key? key, required this.data});

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _DetailHelpPageState();
}

class _DetailHelpPageState extends BasePageState<DetailHelpPage> {
  String? title;

  @override
  void onCreate() {
    title = widget.data.arg1;
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.help_center,
          style: TextStyle(
            fontSize: ScreenUtil.getInstance().getAdapterSize(18),
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColor.colorWhiteDark,
      ),
      body: Container(
        height: ScreenUtil.getInstance().screenHeight,
        width: ScreenUtil.getInstance().screenWidth,
        color: AppColor.colorWhiteDark,
        padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil.getInstance().getAdapterSize(18),
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().getAdapterSize(20),
            ),
            Text(
              'Thời gian xử lý xác nhận giao dịch là x ngày làm việc tính từ lúc phiên chuyển tiền được tạo. Nếu phiên chuyển tiền được tạo vào ngày cuối tuần sẽ được xử lý vào ngày làm việc tiếp theo của tuần kế tiếp.  ',
              style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
