
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/utils/account_utils.dart';
import 'package:tms_partner_app/utils/open_settings/open_settings.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

import 'header_widget.dart';

class PhoneCallBottomSheet {
  PhoneCallBottomSheet._internal();

  static final PhoneCallBottomSheet _instance =
      PhoneCallBottomSheet._internal();

  factory PhoneCallBottomSheet() {
    return _instance;
  }

  void show({required BuildContext context, required String phoneNumber}) {
    BaseBottomSheet().show(
        context: context,
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            headerWidget(context: context, title: S.of(context).call_for),
            Divider(height: 1, color: Colors.black.withOpacity(0.2)),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(8)),
            _itemContact(
                title: S.current.call_customers,
                onTap: () {
                  Navigator.pop(context);
                  OpenSettings.callNumber(phoneNumber);
                }),
            Divider(
                color: Colors.grey,
                height: 0,
                indent: ScreenUtil.getInstance().getAdapterSize(65)),
            _itemContact(
                title: S.current.call_the_operator,
                onTap: () {
                  AppSettingModel? appSetting =
                      AccountUtil.instance.getAppSetting();
                  if (appSetting != null &&
                      appSetting.general?.callCenterPhone != null) {
                    Navigator.pop(context);
                    OpenSettings.callNumber(
                        appSetting.general!.callCenterPhone!);
                  }
                }),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(8)),
          ],
        ));
  }

  Widget _itemContact(
      {required String title, required GestureTapCallback onTap}) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: ScreenUtil.getInstance().getAdapterSize(8)),
      child: ListTile(
        leading: SvgPicture.asset('assets/icon/svg/phone_contact.svg'),
        title: Text(title,
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(14))),
        onTap: onTap,
      ),
    );
  }
}
