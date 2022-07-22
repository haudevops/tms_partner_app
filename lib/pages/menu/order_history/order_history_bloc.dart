
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/data/service/orders_service.dart';
import 'package:tms_partner_app/utils/logs/logger.dart';

class OrderHistoryBloc extends BaseBloc {
  final _getOrderHistory = BehaviorSubject<List<OrderModel>?>();

  Stream<List<OrderModel>?> get streamOrderHistory => _getOrderHistory.stream;

  Future<void> getOrdersHistory(
      {String? code,
      String? external,
      String? store,
      String? serviceType,
      String? status,
      String? submitted}) async {
    _getOrderHistory.sink.add(null);
    await OrdersService.instance
        .getOrders(
            code: code,
            status: status,
            externalCode: external,
        store: store,
            serviceType: serviceType,
            limit: '15',
            submitted: submitted,
            page: "1"
    )
        .then((value) {
      _getOrderHistory.sink.add(value.data);
    }).catchError((error) {
      DebugLog.show('getOrders error: ${error.toString()}');
    });
  }

  @override
  void dispose() {
    _getOrderHistory.close();
  }

  @override
  void onCreate(BuildContext context) {
    // TODO: implement onCreate
  }
}
