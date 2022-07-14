import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tms_partner_app/utils/event_msg.dart';

abstract class BaseBloc {
  final _loadingSubject = BehaviorSubject<bool>();
  final _msgSubject = PublishSubject<EventMsg>();

  Stream<bool> get loadingStream => _loadingSubject.stream;

  Stream<EventMsg> get msgStream => _msgSubject.stream;

  void onCreate(BuildContext context);

  void dispose();

  void showLoading() {
    _loadingSubject.sink.add(true);
  }

  void hiddenLoading() {
    _loadingSubject.sink.add(false);
  }

  void showMsg(String? msg) {
    if (msg != null && msg.isNotEmpty) {
      _msgSubject.sink.add(EventMsg(type: EventMsg.msgSuccess, msg: msg));
    }
  }

  void showMsgError(String? msg) {
    if (msg != null && msg.isNotEmpty) {
      _msgSubject.sink.add(EventMsg(type: EventMsg.msgError, msg: msg));
    }
  }

  void onDestroy() {
    _loadingSubject.close();
    _msgSubject.close();
  }
}