import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/data/service/orders_service.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/utils/constants.dart';

class ConfirmPickGoodsSuccessBloc extends BaseBloc {
  final _orderController = BehaviorSubject<OrderModel?>();

  Stream<OrderModel?> get ordersStream => _orderController.stream;

  late BuildContext _context;

  Future<void> doPickupSuccess(PointTargetFinder pointTargetFinder, OrderModel orderModel) async {
    showLoading();
    await OrdersService.instance
        .doPickupSuccess(
            orderID: orderModel.id, pointId: orderModel.detail?.points?[0].id)
        .then((value) => {
              if (value.errorCode != Constants.ERROR_CODE)
                Navigator.pushNamedAndRemoveUntil(_context, NavigationPage.routeName, (route) => false)
              else
                {
                  showMsg(value.message ??
                      S.current.something_went_wrong_please_try_again)
                }
            });
    hiddenLoading();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void onCreate(BuildContext context) {
    _context = context;
  }
}
