
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/data/service/orders_service.dart';
import 'package:tms_partner_app/utils/constants.dart';
import 'package:tms_partner_app/utils/logs/logger.dart';
import 'package:tms_partner_app/utils/order/business_constant.dart';

class OrdersBloc extends BaseBloc {
  final _statisticalController = BehaviorSubject<StatisticalModel?>();
  final _ordersController = BehaviorSubject<List<OrderModel>?>();

  Stream<StatisticalModel?> get statisticalStream =>
      _statisticalController.stream;

  Stream<List<OrderModel>?> get ordersStream => _ordersController.stream;

  @override
  void dispose() {
    _statisticalController.close();
    _ordersController.close();
  }

  @override
  void onCreate(BuildContext context) {}

  Future<void> getStatistical() async {
    await OrdersService.instance.getStatistical().then((value) {
      _statisticalController.sink.add(value);
    }).catchError((error) {
      DebugLog.show('_getStatistical error: ${error.toString()}');
    });
  }

  Future<void> getOrders(
      {String? code,
      String? external,
      String? phone,
      String? serviceType,
      String? status}) async {
    showLoading();
    // _ordersController.sink.add(null);
    await OrdersService.instance
        .getOrders(
            status: status,
            code: code,
            externalCode: external,
            phone: phone,
            serviceType: serviceType,
            page: '1',
            limit: '2000',
            optimize: true)
        .then((value) {
      // _ordersController.sink.add(_groupListBillOrder(value.data));
    }).catchError((error) {
      DebugLog.show('getOrders error: ${error.toString()}');
    });
    hiddenLoading();
  }

  List<OrderModel> _groupListBillOrder(List<OrderModel>? orders) {
    List<OrderModel> result = [];
    if (orders == null || orders.isEmpty) {
      return result;
    }

    try {
      OrderModel firstOrder = orders[0];
      if(firstOrder.detail?.points != null){
        firstOrder.detail?.groupedPoints = []..addAll(firstOrder.detail!.points!);
      }
      firstOrder.parentOrderId = firstOrder.id;
      if (firstOrder.groups == null) {
        firstOrder.groups = <OrderGroup>[];
      }
      firstOrder.groups?.add(OrderGroup(
        id: firstOrder.id,
        externalCode: firstOrder.externalCode,
        servicerCost: firstOrder.servicerCost,
        orderCoD: firstOrder.cod,
        points: firstOrder.detail?.points
            ?.map((point) => OrderGroupPoint(
                id: point.id,
                externalCode: point.externalCode,
                location: point.location,
                status: point.status,
                type: point.type,
                products: point.products))
            .toList(),
        packages: firstOrder.packages,
        deliveryOrder: firstOrder.deliveryOrder,
        expectedTime: firstOrder.expectedTime,
        detail: DetailModel(distance: firstOrder.detail?.distance),
        deliveryType: firstOrder.deliveryType,
        code: firstOrder.code,
        status: firstOrder.status,
        serviceName: firstOrder.serviceName,
      ));
      result.add(firstOrder);

      for (int i = 1; i < orders.length; i++) {
        OrderModel order = orders[i];
        if(order.detail?.points != null){
          order.detail?.groupedPoints = []..addAll(order.detail!.points!);
        }
        OrderModel? parentOrder = _findParentOrder(order, result);

        if (parentOrder == null) {
          order.parentOrderId = order.id;
          if (order.groups == null) {
            order.groups = <OrderGroup>[];
          }

          order.groups?.add(OrderGroup(
            id: order.id,
            externalCode: order.externalCode,
            servicerCost: order.servicerCost,
            orderCoD: order.cod,
            points: order.detail?.points
                ?.map((point) => OrderGroupPoint(
                    id: point.id,
                    externalCode: point.externalCode,
                    location: point.location,
                    status: point.status,
                    type: point.type,
                    products: point.products))
                .toList(),
            packages: order.packages,
            deliveryOrder: order.deliveryOrder,
            expectedTime: order.expectedTime,
            detail: order.detail,
            deliveryType: order.deliveryType,
            code: order.code,
            status: order.status,
            serviceName: order.serviceName,
          ));
          result.add(order);
        } else {
          order.parentOrderId = parentOrder.id;
          List<LocationModel?> locations = parentOrder.detail!.groupedPoints!
              .map((e) => e.location)
              .toList();

          List<Point>? diffPoint = order.detail?.points
              ?.where((orderPoint) =>
                  orderPoint.type == PointType.DELIVERY_POINT &&
                  !locations.contains(orderPoint.location))
              .toList();
          if (diffPoint != null && diffPoint.isNotEmpty) {
            parentOrder.detail?.groupedPoints?.addAll(diffPoint);
          }
          if (parentOrder.groups == null) {
            parentOrder.groups = [];
          }

          if (parentOrder.groups!
              .where((element) =>
                  _getSOFromExternal(element.externalCode) ==
                  _getSOFromExternal(order.externalCode))
              .isEmpty) {
            parentOrder.countSO++;
          }

          parentOrder.groups?.add(OrderGroup(
            id: order.id,
            externalCode: order.externalCode,
            servicerCost: order.servicerCost,
            orderCoD: order.cod,
            points: order.detail?.points
                ?.map((point) => OrderGroupPoint(
                    id: point.id,
                    externalCode: point.externalCode,
                    location: point.location,
                    status: point.status,
                    type: point.type,
                    products: point.products))
                .toList(),
            packages: order.packages,
            deliveryOrder: order.deliveryOrder,
            expectedTime: order.expectedTime,
            detail: order.detail,
            deliveryType: order.deliveryType,
            code: order.code,
            status: order.status,
            serviceName: order.serviceName,
          ));
        }
      }
    } catch (error) {
      DebugLog.show('groupListBillOrder error: ${error.toString()}');
    }

    hiddenLoading();
    return result;
  }

  OrderModel? _findParentOrder(OrderModel order, List<OrderModel> parents) {
    for (final parent in parents) {
      if (_validForGroup(order, parent)) {
        return parent;
      }
    }
    return null;
  }

  bool _validForGroup(OrderModel order, OrderModel parentOrder) {
    return _isValidOrderType(order, parentOrder) &&
        _isValidMaxGroupSize(parentOrder) &&
        _isOrderTypeMatched(order, parentOrder) &&
        (_isValidPickPointForGroup(order, parentOrder) ||
            _isPointMatched(order, parentOrder));
  }

  bool _isValidOrderType(OrderModel order, OrderModel parentOrder) {
    for (final item in [order, parentOrder]) {
      if (item.serviceType == ServiceType.INSTALL) {
        return false;
      }
    }
    return true;
  }

  bool _isValidMaxGroupSize(OrderModel order) {
    if (order.groups == null) {
      return false;
    }
    return order.groups!.length < Constants.MAX_GROUP;
  }

  bool _isOrderTypeMatched(OrderModel order, OrderModel parentOrder) {
    return order.serviceType == parentOrder.serviceType;
  }

  bool _isValidPickPointForGroup(OrderModel order, OrderModel parentOrder) {
    Point? orderPickPoint = order.detail?.points?.first;
    Point? parentOrderPickPoint = parentOrder.detail?.points?.first;

    return orderPickPoint != null &&
        parentOrderPickPoint != null &&
        orderPickPoint.status == parentOrderPickPoint.status &&
        (orderPickPoint.status == PointStatus.NEW ||
            orderPickPoint.status == PointStatus.POINT_ARRIVED) &&
        orderPickPoint.type == parentOrderPickPoint.type &&
        _checkLocation(
            orderPickPoint.location, parentOrderPickPoint.location) &&
        orderPickPoint.contact?.phone?.trim().toLowerCase() ==
            parentOrderPickPoint.contact?.phone?.trim().toLowerCase();
  }

  bool _checkLocation(
      LocationModel? locationOrder, LocationModel? locationParent) {
    return locationOrder?.lat == locationParent?.lat &&
        locationOrder?.lng == locationParent?.lng &&
        locationOrder?.address?.trim() == locationParent?.address?.trim();
  }

  bool _isPointMatched(OrderModel order, OrderModel parentOrder) {
    List<Point>? pointsA = order.detail?.points;
    List<Point>? pointsB = parentOrder.detail?.points;

    if (pointsA == null ||
        pointsB == null ||
        pointsA.length != pointsB.length) {
      return false;
    }

    for (int i = 0; i < pointsA.length; i++) {
      if (!_checkLocation(pointsA[i].location, pointsB[i].location)) {
        return false;
      }
      if (pointsA[i].status != pointsB[i].status) {
        return false;
      }
      if (pointsA[i].type != pointsB[i].type) {
        return false;
      }
      if (pointsA[i].contact?.phone?.trim().toLowerCase() !=
          pointsB[i].contact?.phone?.trim().toLowerCase()) {
        return false;
      }
      if ((i > 0) &&
              (pointsA[i].storeCode != null &&
                      pointsA[i].storeCode!.isNotEmpty ||
                  pointsB[i].storeCode != null &&
                      pointsB[i].storeCode!.isNotEmpty) &&
              pointsA[i].storeCode != pointsB[i].storeCode ||
          pointsA[i].scanStore != pointsB[i].scanStore &&
              pointsA[i].scanStore != pointsB[i].scanStore) {
        return false;
      }
    }
    return true;
  }

  String _getSOFromExternal(String? externalCode) {
    if (externalCode == null || externalCode.isEmpty) return '';
    List<String> result = externalCode.split('_');
    return result.length > 0 ? result[0] : '';
  }

  void updateUIExpand(List<OrderModel> orders, int index) {
    orders[index].expandGroup = !orders[index].expandGroup;
    _ordersController.sink.add(orders);
  }
}
