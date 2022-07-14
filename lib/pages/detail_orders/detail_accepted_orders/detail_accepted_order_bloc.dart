
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/data/service/orders_service.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/utils/constants.dart';
import 'package:tms_partner_app/utils/logs/logger.dart';
import 'package:tms_partner_app/utils/order/business_constant.dart';
import 'package:tms_partner_app/utils/order/order_utils.dart';

class DetailAcceptedOrderBloc extends BaseBloc {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void onCreate(BuildContext context) {
    // TODO: implement onCreate
  }
  // final _orderController = BehaviorSubject<OrderModel?>();
  //
  // Stream<OrderModel?> get ordersStream => _orderController.stream;
  //
  // late OrderModel _orderModel;
  // late List<OrderGroup> _orderGroups;
  //
  // void initData({required OrderModel orderModel}) {
  //   this._orderModel = orderModel;
  //   this._orderGroups = orderModel.groups ?? [];
  //   getOrder(_orderModel);
  // }
  //
  // @override
  // void dispose() {
  //   _orderController.close();
  // }
  //
  // @override
  // void onCreate(BuildContext context) {}
  //
  // Future<void> getOrder(OrderModel orderModel) async {
  //   showLoading();
  //   if (orderModel.isGrouped()) {
  //     String _orderIds = '';
  //     orderModel.groups?.forEach((element) {
  //       if (element.id != null) {
  //         _orderIds += (element.id! + ',');
  //       }
  //     });
  //     _getOderGroup(orderIds: _orderIds, limit: orderModel.groups?.length ?? 0);
  //   } else {
  //     _getSingleOrder(orderModel.id);
  //   }
  // }
  //
  // Future<void> _getOderGroup(
  //     {required String orderIds, required int limit}) async {
  //   await OrdersService.instance
  //       .getOrderGroup(orderIds: orderIds, limit: limit)
  //       .then((value) {
  //     if (value.errorCode != Constants.ERROR_CODE) {
  //       _onGetListOrderSuccess(value.data);
  //     } else {
  //       showMsg(
  //           value.message ?? S.current.something_went_wrong_please_try_again);
  //     }
  //
  //     hiddenLoading();
  //   }).catchError((error) {
  //     hiddenLoading();
  //     DebugLog.show('_getOderGroup ${error.toString()}');
  //   });
  // }
  //
  // Future<void> _getSingleOrder(String? orderId) async {
  //   await OrdersService.instance.getOrder(orderId: orderId).then((value) {
  //     if (value.errorCode != Constants.ERROR_CODE) {
  //       _orderController.sink.add(value);
  //     } else {
  //       showMsg(
  //           value.message ?? S.current.something_went_wrong_please_try_again);
  //     }
  //     hiddenLoading();
  //   }).catchError((error) {
  //     hiddenLoading();
  //     DebugLog.show('_getSingleOrder ${error.toString()}');
  //   });
  // }
  //
  // void _onGetListOrderSuccess(List<OrderModel>? orders) {
  //   if (orders != null) {
  //     for (final orderGroup in _orderGroups) {
  //       for (final order in orders) {
  //         if (orderGroup.id == order.id) {
  //           orderGroup.points = order.detail?.points
  //               ?.map((point) => OrderGroupPoint(
  //                   id: point.id,
  //                   externalCode: point.externalCode,
  //                   location: point.location,
  //                   status: point.status,
  //                   type: point.type,
  //                   products: point.products))
  //               .toList();
  //           orderGroup.orderCoD = order.cod;
  //           orderGroup.deliveryOrder = order.deliveryOrder;
  //           orderGroup.servicerCost = order.servicerCost;
  //         }
  //         if (this._orderModel.id == order.id) {
  //           this._orderModel = order;
  //           this._orderModel.groups = _orderGroups;
  //         }
  //       }
  //     }
  //
  //     for (final order in orders) {
  //       List<LocationModel?>? locations =
  //           this._orderModel.detail?.points?.map((e) => e.location).toList();
  //
  //       if (locations == null) {
  //         locations = [];
  //       }
  //
  //       List<Point>? diffPoint = order.detail?.points
  //           ?.where((point) =>
  //               point.type == PointType.DELIVERY_POINT &&
  //               !locations!.contains(point.location))
  //           .toList();
  //
  //       if (diffPoint != null && diffPoint.isNotEmpty) {
  //         this._orderModel.detail?.points?.addAll(diffPoint);
  //       }
  //     }
  //     _orderController.sink.add(this._orderModel);
  //   }
  // }
  //
  // PointTargetFinder findPointsAction(OrderModel orderModel) {
  //   Point? _currentPoint =
  //       OrderUtils.getCurrentPointProgress(points: orderModel.detail?.points);
  //   Point? _nextPoint = OrderUtils.getNextPointProgress(
  //       pointIDCurrent: _currentPoint?.id, points: orderModel.detail?.points);
  //   int? _currentPointIndex;
  //
  //   if (_currentPoint != null) {
  //     _currentPointIndex = orderModel.detail?.points?.indexOf(_currentPoint);
  //   }
  //
  //   int? _nextPointIndex = _nextPoint != null
  //       ? orderModel.detail?.points?.indexOf(_nextPoint)
  //       : -1;
  //
  //   return PointTargetFinder(
  //       point: _currentPoint,
  //       currentPointIndex: _currentPointIndex,
  //       nexPoint: _nextPoint,
  //       nextPointIndex: _nextPointIndex,
  //       status: _currentPoint?.status,
  //       type: _currentPoint?.type);
  // }
  //
  // String getCapacity(SizeModel? sizeModel) {
  //   if (sizeModel == null) {
  //     return '';
  //   }
  //   double capacity = 0.0;
  //   if (sizeModel.volume != null) {
  //     capacity = sizeModel.volume!;
  //   } else {
  //     capacity = (sizeModel.length ?? 0) *
  //         (sizeModel.width ?? 0) *
  //         (sizeModel.height ?? 0);
  //   }
  //
  //   return '${OrderUtils.round(capacity, 3)} m\u00B3';
  // }
  //
  // String getSize(SizeModel? sizeModel) {
  //   if (sizeModel == null) {
  //     return '';
  //   }
  //   if (sizeModel.length != 0 ||
  //       sizeModel.width != 0 ||
  //       sizeModel.height != 0) {
  //     return '${sizeModel.length}x${sizeModel.width}x${sizeModel.height}m';
  //   } else {
  //     return '';
  //   }
  // }
  //
  // Future<void> arrived(
  //     PointTargetFinder pointTargetFinder, OrderModel orderModel) async {
  //   if (pointTargetFinder.point == null) {
  //     return;
  //   }
  //   if (orderModel.isGrouped()) {
  //     LocationData _locationData = await Location().getLocation();
  //     List<ArrivedGroupRequest> arrivedGroupRequests = [];
  //
  //     for (final orderGroup in orderModel.groups!) {
  //       arrivedGroupRequests.add(ArrivedGroupRequest(
  //           orderId: orderGroup.id,
  //           pointId:
  //               orderGroup.points?[pointTargetFinder.currentPointIndex!].id,
  //           lat: _locationData.latitude,
  //           lng: _locationData.longitude));
  //     }
  //   } else {}
  // }
}
