import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/constants.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class ContactHelpPage extends BasePage {
  static const routeName = '/ContactHelpPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _ContactHelpPageState();
}

class _ContactHelpPageState extends BasePageState<ContactHelpPage> {
  List<ItemSupportModel> itemSupport = [
    ItemSupportModel(
        id: Constants.ITEM_SUPPORT_HOTLINE,
        title: S.current.menu_history,
        image: 'assets/icon/svg/menu_ic_history.svg',
        content: '1800 6311'),
    ItemSupportModel(
        id: Constants.ITEM_SUPPORT_FACEBOOK,
        title: S.current.menu_statistical,
        image: 'assets/icon/svg/menu_ic_statistical.svg',
        content: 'https://www.facebook.com/etonx.vn'),
    ItemSupportModel(
        id: Constants.ITEM_SUPPORT_WEBSITE,
        title: S.current.menu_wallet,
        image: 'assets/icon/svg/menu_ic_wallet.svg',
        content: 'http://www.eton.vn'),
    ItemSupportModel(
        id: Constants.ITEM_SUPPORT_MAIL,
        title: S.current.menu_share_code,
        image: 'assets/icon/svg/menu_ic_share_code.svg',
        content: '')
  ];

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
          S.current.contact_help,
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
          children: [],
        ),
      ),
    );
  }
}
