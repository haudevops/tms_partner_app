import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class TempPolicyPage extends BasePage {
  static const routeName = '/TempPolicyPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _TempPolicyPageState();
}

class _TempPolicyPageState extends BasePageState<TempPolicyPage> {
  @override
  void onCreate() {
    // TODO: implement onCreate
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
          S.current.terms_policy,
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
        padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
        color: AppColor.colorWhiteDark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Điều 1: Giải thích từ ngữ',
              style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(18),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().getAdapterSize(12),
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(16),
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().getAdapterSize(16),
            ),
            Text(
              'Điều 1: Giải thích từ ngữ',
              style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(18),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().getAdapterSize(12),
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
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
