import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/service/other_service.dart';
import 'package:tms_partner_app/utils/logs/logger.dart';

class HomeBloc extends BaseBloc {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void onCreate(BuildContext context) {
    // TODO: implement onCreate
  }
  // final _locationController = BehaviorSubject<Position>();
  //
  // Stream<Position> get locationStream => _locationController.stream;
  //
  // @override
  // void dispose() {
  //   _locationController.close();
  // }
  //
  // @override
  // void onCreate(BuildContext context) {
  //   _getUserLocation();
  //   // Demo Api
  //   _getNews('1', '15', '', '', '-1');
  // }
  //
  // Future<void> _getUserLocation() async {
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((position) {
  //     _locationController.sink.add(position);
  //   }).catchError((error) {
  //     DebugLog.show(error.toString());
  //   });
  // }
  //
  // Future<void> _getNews(String page, String limit, String newsCatIds,
  //     String sortBy, String sortWay) async {
  //   showLoading();
  //
  //   await OtherService.instance
  //       .getNews(page, limit, newsCatIds, sortBy, sortWay)
  //       .then((value) {
  //     hiddenLoading();
  //   }).catchError((error) {
  //     hiddenLoading();
  //   });
  // }
}
