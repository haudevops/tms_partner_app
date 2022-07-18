import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class SignImagePage extends BasePage{
  SignImagePage({Key? key, required this.data});

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _SignImagePageState();
  static const routeName = '/SignImagePage';
  final ScreenArguments data;

}

class _SignImagePageState extends BasePageState<SignImagePage>{
  String? _signImage;

  @override
  void onCreate() {
    _signImage = widget.data.arg1;
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
          S.current.sign_image,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColor.colorWhiteDark,
      ),
      body: Container(
        width: ScreenUtil.getInstance().screenWidth,
        height: ScreenUtil.getInstance().screenHeight,
        color: AppColor.colorWhiteDark,
        padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          // width: ScreenUtil.getInstance().getAdapterSize(80),
          // height: ScreenUtil.getInstance().getAdapterSize(80),
          alignment: Alignment.topLeft,
          imageUrl: _signImage ?? '',
          placeholder: (context, url) => Image.asset(
            'assets/images/no_image.png',
            alignment: Alignment.topLeft,
            fit: BoxFit.contain,
            width: ScreenUtil.getInstance().getAdapterSize(80),
            height: ScreenUtil.getInstance().getAdapterSize(80),
          ),
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/no_image.png',
            alignment: Alignment.topLeft,
            fit: BoxFit.contain,
            width: ScreenUtil.getInstance().getAdapterSize(80),
            height: ScreenUtil.getInstance().getAdapterSize(80),
          ),
        ),
      ),
    );
  }


}