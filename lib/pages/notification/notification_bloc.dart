
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/data/service/notification_service.dart';
import 'package:tms_partner_app/utils/logs/logger.dart';

class NotificationBloc extends BaseBloc {
  final _listNotification = BehaviorSubject<ActivitiesModel>();
  final _isFinish = BehaviorSubject<bool>();
  ActivitiesModel? dataActivities;

  Stream<ActivitiesModel> get listNotificationStream =>
      _listNotification.stream;

  Stream<bool> get isFinish => _isFinish.stream;

  @override
  void dispose() {
    _listNotification.close();
    _isFinish.close();
  }

  @override
  void onCreate(BuildContext context) {
    getNotification();
  }

  Future<void> getNotification([int page = 1]) async {
    await NotificationService.instance.getNotification(page, 15).then((value) {
      if (value.data != null) {
        if (page == 1) {
          dataActivities = value;
        } else {
          dataActivities?.data?.addAll(value.data!);
        }
      }
      _listNotification.sink.add(dataActivities!);
    }).catchError((error) {
      DebugLog.show(error.toString());
    });
  }
}
