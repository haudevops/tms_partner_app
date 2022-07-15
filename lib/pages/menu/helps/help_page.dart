import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

class HelpPage extends BasePage {
  static const routeName = '/HelpPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _HelpPageState();
}

class _HelpPageState extends BasePageState<HelpPage> {
  List<String> title = [
    'Làm sao để biết được thông tin người nhận hàng để giao hàng và lắp đặt?',
    'Làm sao để biết được thông tin người nhận hàng để giao hàng và lắp đặt?',
    'Làm sao để biết được thông tin người nhận hàng để giao hàng và lắp đặt?',
    'Làm sao để biết được thông tin người nhận hàng để giao hàng và lắp đặt?',
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
      body: Stack(
        children: [
          Container(
            height: ScreenUtil.getInstance().screenHeight,
            width: ScreenUtil.getInstance().screenWidth,
            color: AppColor.colorWhiteDark,
            padding:
                EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bạn gặp vấn đề gì?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil.getInstance().getAdapterSize(18),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().getAdapterSize(20),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: title.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, DetailHelpPage.routeName, arguments: ScreenArguments(arg1: title[index]));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                title[index],
                                style: TextStyle(
                                  fontSize: ScreenUtil.getInstance()
                                      .getAdapterSize(16),
                                ),
                                maxLines: 2,
                              ),
                            ),
                            const Icon(
                              Icons.navigate_next,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: ScreenUtil.getInstance().getAdapterSize(16),
            child: Column(
              children: [
                const Divider(),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.getInstance().getAdapterSize(16),
                  ),
                  child: ButtonSubmitWidget(
                    onPressed: () {
                      Navigator.pushNamed(context, ContactHelpPage.routeName);
                    },
                    title: S.of(context).contact_help.toUpperCase(),
                    colorTitle: Colors.white,
                    height: ScreenUtil.getInstance().getAdapterSize(44),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
