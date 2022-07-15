
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

// @Auth: hau.tran
// @Description: Share Code Page
// @Date: 12/01/2022

class ShareCodePage extends BasePage {
  ShareCodePage({required this.data});

  static const routeName = '/ShareCodePage';
  final ScreenArguments data;
  @override
  BasePageState<BasePage<BaseBloc>> getState() => _ShareCodePageState();
}

class _ShareCodePageState extends BasePageState<ShareCodePage> {
  String? _phone;

  @override
  void onCreate() {
    _phone = widget.data.arg1;
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.share),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColor.colorWhiteDark,
      ),
      body: Container(
        color: AppColor.colorWhiteDark,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().getAdapterSize(60)),
                child: SvgPicture.asset('assets/images/img_share_code.svg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil.getInstance().getAdapterSize(20)),
              child: Text(
                S.current.introducing_partners,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(18),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil.getInstance().getAdapterSize(10),
                  bottom: ScreenUtil.getInstance().getAdapterSize(10),
                  right: ScreenUtil.getInstance().getAdapterSize(30),
                  left: ScreenUtil.getInstance().getAdapterSize(30)),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                    color: AppColor.colorGray),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil.getInstance().getAdapterSize(30)),
              child: Text(
                S.current.your_referral_code,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                    color: AppColor.colorGray),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(8)),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _phone ?? '0987654321',
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().getAdapterSize(16), color: Colors.black),
                    ),
                    SizedBox(width: ScreenUtil.getInstance().getAdapterSize(10)),
                    SvgPicture.asset('assets/icon/svg/ic_share.svg')
                  ],
                ),
                onPressed: () {
                  Share.share('Mã giới thiệu của bạn bè: ${_phone!}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
