import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';

class DetailOrderHistoryPage extends BasePage{
  static const routeName = '/DetailOrderHistoryPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _DetailOrderHistoryPageState();

}

class _DetailOrderHistoryPageState extends BasePageState<DetailOrderHistoryPage>{
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.menu_history, style: const TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColor.colorWhiteDark,
      ),
    );
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

}