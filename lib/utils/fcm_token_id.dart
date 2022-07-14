import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:package_info/package_info.dart';

class FCMGetTokenID{

  FCMGetTokenID._internal();

  static final FCMGetTokenID instance = FCMGetTokenID._internal();

  Future<String?> getToken() async {
    // return await FirebaseMessaging.instance.getToken();
  }

  Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      // return '${packageInfo.packageName}-${iosDeviceInfo.identifierForVendor}';
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      // return '${packageInfo.packageName}-${androidDeviceInfo.androidId}';
    }
  }
}