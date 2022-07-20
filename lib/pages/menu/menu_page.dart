import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/constants.dart';
import 'package:tms_partner_app/utils/logs/logger.dart';
// import 'package:tms_partner_app/utils/prefs_util.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';
import '../pages.dart';

// @Auth: hau.tran
// @Description: Menu Page
// @Date: 26/11/2021

class MenuPage extends BasePage {
  MenuPage({Key? key}) : super(bloc: MenuBloc());

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _MenuPageState();
}

class _MenuPageState extends BasePageState<MenuPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late MenuBloc _bloc;
  bool checkOrder = false;
  String? phone;

  List<ItemSettingsModel> getItemsListOne() {
    return [
      ItemSettingsModel(
          id: Constants.ITEM_MENU_HISTORY,
          title: S.current.menu_history,
          image: 'assets/icon/svg/menu_ic_history.svg'),
      ItemSettingsModel(
          id: Constants.ITEM_MENU_STATISTICAL,
          title: S.current.menu_statistical,
          image: 'assets/icon/svg/menu_ic_statistical.svg'),
      ItemSettingsModel(
          id: Constants.ITEM_MENU_WALLET,
          title: S.current.menu_wallet,
          image: 'assets/icon/svg/menu_ic_wallet.svg'),
      ItemSettingsModel(
          id: Constants.ITEM_MENU_SHARE_CODE,
          title: S.current.menu_share_code,
          image: 'assets/icon/svg/menu_ic_share_code.svg')
    ];
  }

  List<ItemSettingsModel> getItemsListTwo() {
    return [
      ItemSettingsModel(
          id: Constants.ITEM_MENU_NEWS,
          title: S.current.menu_news,
          image: 'assets/icon/svg/menu_ic_news.svg'),
      ItemSettingsModel(
          id: Constants.ITEM_MENU_TERMS_POLICY,
          title: S.current.terms_policy,
          image: 'assets/icon/svg/menu_ic_term_policy.svg'),
      ItemSettingsModel(
          id: Constants.ITEM_MENU_HELP,
          title: S.current.menu_help,
          image: 'assets/icon/svg/menu_ic_help.svg'),
      ItemSettingsModel(
          id: Constants.ITEM_MENU_SETTING,
          title: S.current.menu_setting,
          image: 'assets/icon/svg/menu_ic_setting.svg')
    ];
  }

  @override
  void onCreate() {
    _bloc = getBloc();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).functions,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: ScreenUtil.getInstance().getAdapterSize(18)),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.colorWhiteDark,
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil.getInstance().getAdapterSize(10),),
        color: AppColor.colorDarkGray,
        width: ScreenUtil.getInstance().screenWidth,
        height: ScreenUtil.getInstance().screenHeight,
        child: RefreshIndicator(
          onRefresh: () async {
            // _bloc.getUserInfo();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<ProfileModel?>(
                  stream: _bloc.userInfoStream,
                  builder: (context, snapshot) {
                    phone = snapshot.data?.phone;
                    return _itemInfoUserWidget(snapshot.data);
                  },
                ),
                _itemCard(getItemsListOne()),
                _itemCard(getItemsListTwo()),
                _itemLogoutWidget(),
                SizedBox(height: ScreenUtil.getInstance().getAdapterSize(5)),
                _itemVersionWidget(),
                _itemBuildByWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemInfoUserWidget(ProfileModel? userInfo) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(
          bottom: ScreenUtil.getInstance().getAdapterSize(8),
          top: ScreenUtil.getInstance().getAdapterSize(8)),
      elevation: 0,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, UserInfoPage.routeName,
                  arguments: ScreenArguments(arg1: userInfo))
              .then((value) => {
                    // _bloc.getUserInfo(),
                  });
        },
        leading: Container(
          // borderRadius: BorderRadius.circular(25),
          height: 50,
          width: 50,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: userInfo?.images?[0] ?? '',
            placeholder: (context, url) =>
                Image.asset('assets/images/user.jpeg'),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/user.jpeg'),
          ),
        ),
        title: Text(
          userInfo?.fullName ?? 'Tài xế Supra',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil.getInstance().getAdapterSize(16)),
        ),
        subtitle: Text(
          '${userInfo?.loyaltyPoint ?? 0} ${S.current.point}',
          style: TextStyle(
              color: Colors.grey,
              fontSize: ScreenUtil.getInstance().getAdapterSize(13)),
        ),
        trailing: Icon(Icons.chevron_right),
        dense: true,
      ),
    );
  }

  Widget _itemFunctionWidget(
      {required String text,
      required String imageXML,
      required GestureTapCallback onTap,
      Color? textColor}) {
    return ListTile(
      leading: Container(
        height: ScreenUtil.getInstance().getAdapterSize(35),
        width: ScreenUtil.getInstance().getAdapterSize(35),
        child: SvgPicture.asset(imageXML),
      ),
      title: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _itemCard(List<ItemSettingsModel> items) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        children: items
            .map((e) => Column(
                  children: [
                    _itemFunctionWidget(
                        text: e.title,
                        imageXML: e.image,
                        onTap: () {
                          _onClickItem(e.id);
                        }),
                    e != items[items.length - 1]
                        ? Divider(
                            color: Colors.grey,
                            height: 0,
                            indent: ScreenUtil.getInstance().getAdapterSize(65),
                            endIndent:
                                ScreenUtil.getInstance().getAdapterSize(20))
                        : SizedBox(),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget _itemLogoutWidget() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: _itemFunctionWidget(
          text: S.of(context).menu_logout,
          imageXML: 'assets/icon/svg/menu_ic_logout.svg',
          textColor: Colors.red ,
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      title: Text(S.current.menu_logout,
                          textAlign: TextAlign.center),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(S.current.logout_confirm,
                              textAlign: TextAlign.center),
                          SizedBox(
                              height:
                                  ScreenUtil.getInstance().getAdapterSize(15)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: ScreenUtil.getInstance()
                                    .getAdapterSize(110),
                                height: ScreenUtil.getInstance()
                                    .getAdapterSize(40),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(AppColor.colorWhiteDark),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                ScreenUtil.getInstance().getAdapterSize(8)),
                                            side: BorderSide(color: AppColor.orderStatusYellow)
                                          ))),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    S.current.cancel.toUpperCase(),
                                    style: TextStyle(
                                        color: AppColor.orderStatusYellow,
                                        fontSize: ScreenUtil.getInstance().getAdapterSize(14)),
                                  ),
                                ),
                              ),
                              SizedBox(width: ScreenUtil.getInstance().getAdapterSize(12),),
                              ButtonSubmitWidget(
                                  title: S.current.menu_logout.toUpperCase(),
                                  onPressed: () {
                                    _clearToken();
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            SplashPage.routeName,
                                            (Route<dynamic> route) => false);
                                  },
                                  width: ScreenUtil.getInstance()
                                      .getAdapterSize(110),
                                  height: ScreenUtil.getInstance()
                                      .getAdapterSize(40),
                                  colorTitle: Colors.white),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }

  Widget _itemVersionWidget() {
    // return StreamBuilder<String>(
    //   stream: _bloc.versionAppStream,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //       return Container();
    //     }
    //     return Text(
    //       '${S.of(context).version} ${snapshot.data ?? ''}',
    //       style:
    //           TextStyle(fontSize: ScreenUtil.getInstance().getAdapterSize(15)),
    //     );
    //   },
    // );
    return Container();
  }

  Widget _itemBuildByWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(S.of(context).info_app),
        SizedBox(width: ScreenUtil.getInstance().getAdapterSize(5)),
        Image.asset('assets/images/logo_supra_black.png',
            width: ScreenUtil.getInstance().getAdapterSize(60),
            height: ScreenUtil.getInstance().getAdapterSize(30))
      ],
    );
  }

  void _onClickItem(String id) {
    switch (id) {
      case Constants.ITEM_MENU_HISTORY:
        Navigator.pushNamed(context, OrderHistoryPage.routeName);
        break;
      case Constants.ITEM_MENU_STATISTICAL:
        DebugLog.show('Click STATISTICAL');
        break;
      case Constants.ITEM_MENU_WALLET:
        DebugLog.show('Click WALLET');
        break;
      case Constants.ITEM_MENU_SHARE_CODE:
        Navigator.pushNamed(context, ShareCodePage.routeName,
            arguments: ScreenArguments(arg1: phone));
        break;
      case Constants.ITEM_MENU_NEWS:
        DebugLog.show('Click NEWS');
        break;
      case Constants.ITEM_MENU_TERMS_POLICY:
        DebugLog.show('Click TERMS POLICY');
        Navigator.pushNamed(context, TempPolicyPage.routeName);
        break;
      case Constants.ITEM_MENU_HELP:
        Navigator.pushNamed(context, HelpPage.routeName);
        break;
      case Constants.ITEM_MENU_SETTING:
        Navigator.pushNamed(context, SettingPage.routeName);
        break;
      default:
        break;
    }
  }

  Future<void> _clearToken() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
