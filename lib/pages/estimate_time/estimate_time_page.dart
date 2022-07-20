import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class EstimatedTimePage extends BasePage {
  EstimatedTimePage({Key? key, required this.data});

  static const routeName = '/EstimatedTimePage';
  final ScreenArguments data;

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _EstimatedTimePageState();
}

class _EstimatedTimePageState extends BasePageState<EstimatedTimePage> {
  String? address;
  String? time;

  @override
  void onCreate() {
    address = widget.data.arg1;
    time = widget.data.arg2;
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
          S.current.estimated_time,
          style: const TextStyle(color: Colors.black),
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
        child: Column(
          children: [
            Container(
              height: ScreenUtil.getInstance().getAdapterSize(140),
              width: ScreenUtil.getInstance().screenWidth,
              color: AppColor.colorWhiteDark,
              padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Điểm kế tiếp:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(top: ScreenUtil.getInstance().getAdapterSize(16)),
                    leading: SvgPicture.asset(
                      'assets/icon/svg/ic_flag_address.svg',
                      width: 35,
                      height: 35,
                    ),
                    title: Text(
                      address ??
                          '331C Trần Hưng Đạo, Phường Cô Giang, Quận 1, Thành phố Hồ Chí Minh',
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                          color: Colors.black),
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      color: AppColor.colorGray,
                    ),
                  ),
                  Divider(indent: ScreenUtil.getInstance().getAdapterSize(50), thickness: 1,),
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil.getInstance().getAdapterSize(50)),
                    child: Text(
                      '*Mặc định theo lộ trình',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColor.colorTextGray,
                        fontStyle: FontStyle.italic,
                        fontSize: ScreenUtil.getInstance().getAdapterSize(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: ScreenUtil.getInstance().getAdapterSize(10),
              color: const Color(0xFFEDEDED),
            ),
          ],
        ),
      ),
    );
  }
}
