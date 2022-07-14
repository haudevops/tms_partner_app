
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:tms_partner_app/base/base_bloc.dart';
import 'package:tms_partner_app/data/service/other_service.dart';
import 'package:tms_partner_app/utils/account_utils.dart';
import 'package:tms_partner_app/utils/logs/logger.dart';
import 'package:tms_partner_app/utils/prefs_const.dart';
import 'package:tms_partner_app/utils/prefs_util.dart';

class NavigationBloc extends BaseBloc {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void onCreate(BuildContext context) {
    // TODO: implement onCreate
  }
  // @override
  // void dispose() {}
  //
  // @override
  // void onCreate(BuildContext context) {}

  // Future<void> sendLocation(LocationData locationData) async {
  //   await OtherService.instance
  //       .pushLocation(
  //           vehicleTypeId: AccountUtil.instance.getUserData()?.vehicle?.id,
  //           address: '',
  //           lat: locationData.latitude,
  //           lng: locationData.longitude,
  //           bearing: 0.0)
  //       .then((value) {
  //     if (value.accuracy != null && value.nextInterval != null) {
  //       PrefsUtil.putString(PrefsCache.LOCATION_ACCURACY, value.accuracy!);
  //       PrefsUtil.putInt(PrefsCache.LOCATION_INTERVAL, value.nextInterval!);
  //     }
  //   }).catchError((error) {
  //     DebugLog.show('sendLocation error: ${error.toString()}');
  //   });
  // }
}
