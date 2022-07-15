import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class NotificationDetailPage extends BasePage {
  NotificationDetailPage({Key? key, required this.data});

  final ScreenArguments data;
  static const routeName = '/NotificationDetailPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() =>
      _NotificationDetailPageState();
}

class _NotificationDetailPageState
    extends BasePageState<NotificationDetailPage> {
  String? title;
  String? content;

  @override
  void onCreate() {
    title = widget.data.arg1;
    content = widget.data.arg2;
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
          title ?? '',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: ScreenUtil.getInstance().getAdapterSize(18)),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColor.colorWhiteDark,
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        height: ScreenUtil.getInstance().screenHeight,
        width: ScreenUtil.getInstance().screenWidth,
        color: AppColor.colorWhiteDark,
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil.getInstance().getAdapterSize(16),
            vertical: ScreenUtil.getInstance().getAdapterSize(18)),
        child: Text(
          content ?? '',
          style:
              TextStyle(fontSize: ScreenUtil.getInstance().getAdapterSize(16)),
        ),
      ),
    );
  }
}
