

import 'dart:math';

import 'package:intl/intl.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/utils/order/business_constant.dart';
import 'package:tms_partner_app/utils/order/point_status_enum.dart';


class OrderUtils {
  static double getTotalCost(List<OrderGroup>? groups) {
    if (groups == null) {
      return 0;
    }
    double result = 0;
    for (OrderGroup orderGroup in groups) {
      if (orderGroup.servicerCost != null) {
        result += orderGroup.servicerCost!;
      }
    }
    return result;
  }

  static int? getTotalCod(OrderModel order) {
    if (order.isGrouped()) {
      int _count = 0;
      for (final item in order.groups!) {
        if (item.orderCoD != null && item.orderCoD?.total != null) {
          _count = _count + item.orderCoD!.total!;
        }
      }
      return _count;
    } else {
      return order.cod?.total;
    }
  }

  static String? getStoreCode(OrderModel? orderModel) {
    if (orderModel != null) {
      if (orderModel.detail != null) {
        final data = orderModel.detail!.points?.where((element) =>
            element.storeCode != null && element.storeCode!.isNotEmpty);

        if (data != null && data.isNotEmpty) {
          return data.first.storeCode;
        }
      }
    }
    return '';
  }

  static String? getPointsExternalCode(OrderModel orderModel) {
    StringBuffer result = new StringBuffer();
    if (orderModel.externalCode != null &&
        orderModel.externalCode!.isNotEmpty) {
      result.write(orderModel.externalCode);
    } else {
      if (orderModel.isGrouped()) {
        for (final item in orderModel.groups!) {
          if (item.externalCode != null && item.externalCode!.isNotEmpty) {
            result.write(item.externalCode);
          }
        }
      } else {
        result.write(_getPointsExternalCode(orderModel.detail!.points!
            .map((point) => OrderGroupPoint(
                id: point.id,
                externalCode: point.externalCode,
                location: point.location,
                status: point.status,
                type: point.type,
                products: point.products))
            .toList()));
      }

      if (result.length > 0) {
        result.toString().substring(0, result.length - 1);
      }

      if (result.length > 0) {
        result.toString().substring(0, result.length - 1);
      }
    }

    return result.toString().trim();
  }

  static String _getPointsExternalCode(List<OrderGroupPoint> points) {
    StringBuffer result = new StringBuffer();
    for (final item in points) {
      if (item.externalCode != null && item.externalCode!.isNotEmpty) {
        result.write('${item.externalCode}, ');
      }
    }
    return result.toString();
  }

  static List<Point>? getOrderPoints(OrderModel orderModel) {
    return orderModel.isGrouped()
        ? orderModel.detail?.groupedPoints
        : orderModel.detail?.points;
  }

  static bool isOrderWin(OrderModel? orderModel) {
    if (orderModel == null) {
      return false;
    }
    if (orderModel.detail == null) {
      return false;
    }
    if (orderModel.detail?.points == null) {
      return false;
    }
    if (orderModel.detail!.points!.length < 2) {
      return false;
    }

    return orderModel.detail!.points![1].scanStore != null &&
        orderModel.detail!.points![1].scanStore! &&
        orderModel.detail!.points![1].storeCode != null &&
        orderModel.detail!.points![1].storeCode!.isNotEmpty;
  }

  static String? getPackageCodeChildOrderGroup(OrderModel? orderModel) {
    if (orderModel == null) {
      return '';
    }
    if (orderModel.groups == null) {
      return orderModel.code;
    }
    if (orderModel.groups!.length < 2) {
      return '';
    }

    StringBuffer result = new StringBuffer();
    orderModel.groups?.forEach((element) {
      result.write('${element.code}, ');
    });

    if (result.length > 0) {
      result.toString().substring(result.length - 1);
    }
    if (result.length > 0) {
      result.toString().substring(result.length - 1);
    }
    return result.toString();
  }

  static String getPaymentType(String? paymentMethod) {
    if (paymentMethod == null || paymentMethod.isEmpty) {
      return 'Tài khoản';
    }

    if (paymentMethod == Payment.CASH) {
      return 'Tiền mặt';
    } else if (paymentMethod == Payment.ATM) {
      return 'ATM';
    } else {
      return 'Tài khoản';
    }
  }

  static Point? getCurrentPointProgress({required List<Point>? points}) {
    if (points == null) {
      return null;
    }

    if (points.length > 1) {
      for (final pointInfo in points) {
        if (pointInfo.status != null && isProgressPoint(pointInfo.status!)) {
          return pointInfo;
        }
      }
      Point? newPoint;
      Point? laterPoint;
      Point? pendingPoint;
      List<Point>? pointNeedExecute = getListPointNeedExecute(points: points);
      if (pointNeedExecute != null) {
        for (final pointInfo in pointNeedExecute) {
          if (newPoint == null) {
            if (pointInfo.status == PointStatus.NEW) newPoint = pointInfo;
          }
          if (laterPoint == null) {
            if (pointInfo.status == PointStatus.LATER) laterPoint = pointInfo;
          }
          if (pendingPoint == null) {
            if (pointInfo.status == PointStatus.PENDING)
              pendingPoint = pointInfo;
          }
          if (pointInfo.status == PointStatus.POINT_ARRIVED) return pointInfo;
        }
        return newPoint != null
            ? newPoint
            : (laterPoint != null ? laterPoint : pendingPoint);
      }
    } else {
      return points.isEmpty ? Point() : points[0];
    }
  }

  static bool isProgressPoint(int status) {
    return status == PointStatusEnum.IN_PROGRESS.status;
  }

  static bool isPickPoint(int? type) {
    return type == PointType.PICK_POINT;
  }

  static bool isReturnPoint(int? type) {
    return type == PointType.RETURN_POINT;
  }

  static List<Point>? getListPointNeedExecute({required List<Point>? points}) {
    if (points == null) {
      return null;
    }
    List<Point> results = [];
    for (Point pointInfo in points) {
      if (isDeliveryProgressPoint(
          status: pointInfo.status, type: pointInfo.type)) {
        Point? pickPoint =
            getPickPointByPointID(pickPointID: pointInfo.id, points: points);
        if (pickPoint != null) {
          results.add(pickPoint);
        }
      } else {
        if (!ignorePoint(pointInfo.status, pointInfo.type)) {
          results.add(pointInfo);
        }
      }
    }
    return results;
  }

  static List<Point>? getListPointNeedExecuteID(
      {required String? pointID, required List<Point>? points}) {
    if (pointID == null || points == null) {
      return null;
    }
    List<Point> results = [];
    for (final point in points) {
      if (pointID != point.id) {
        if (isDeliveryProgressPoint(status: point.status, type: point.type)) {
          Point? pickPoint = getPickPointByPointID(
              pickPointID: point.pickPointId, points: points);
          if (pickPoint != null &&
              pickPoint.status == PointStatusEnum.PICK_SUCCESS.status)
            results.add(point);
        } else {
          if (!OrderUtils.ignorePoint(point.status, point.type)) if (!OrderUtils
              .isReturnPoint(point.type)) results.add(point);
        }
      }
    }
    return results;
  }

  static bool isDeliveryProgressPoint(
      {required int? status, required int? type}) {
    if (type == PointType.DELIVERY_POINT ||
        type == PointType.DELIVERY_INSTALLATION_POINT) {
      PointStatusEnum pointStatus = PointStatusEnum.parse(status, type);
      switch (pointStatus) {
        case PointStatusEnum.DELIVERED:
        case PointStatusEnum.DELIVER_FAILED:
          return false;
        default:
          return true;
      }
    }
    return false;
  }

  static Point? getPickPointByPointID(
      {required String? pickPointID, required List<Point>? points}) {
    if (pickPointID == null || points == null) {
      return null;
    }

    for (final pointPickup in points) {
      if (isPickPoint(pointPickup.type)) {
        if (pickPointID == pointPickup.id) {
          return pointPickup;
        }
      }
    }
    return null;
  }

  static bool ignorePoint(int? status, int? type) {
    PointStatusEnum pointStatus = PointStatusEnum.parse(status, type);
    switch (pointStatus) {
      case PointStatusEnum.ADVICE_FAILED:
      case PointStatusEnum.PICK_FAILED:
      case PointStatusEnum.INSTALL_FAILED:
      case PointStatusEnum.DELIVER_FAILED:
      case PointStatusEnum.DELIVERED:
      case PointStatusEnum.INSTALLED:
      case PointStatusEnum.POINT_CANCEL:
      case PointStatusEnum.POINT_SKIPPED:
      case PointStatusEnum.POINT_INCIDENT_DONE:
      case PointStatusEnum.RETURNED:
      case PointStatusEnum.RETURN_FAILED:
      case PointStatusEnum.PICK_SUCCESS:
      case PointStatusEnum.DONE:
      case PointStatusEnum.FAILED:
        return true;
      default:
        return false;
    }
  }

  static Point? getNextPointProgress(
      {required String? pointIDCurrent, required List<Point>? points}) {
    if (pointIDCurrent == null || points == null) {
      return null;
    }

    if (points.length > 1) {
      List<Point>? orderPoints =
          getListPointNeedExecuteID(pointID: pointIDCurrent, points: points);
      if (orderPoints != null) {
        for (final nextPoint in orderPoints) {
          if (pointIDCurrent != nextPoint.id) {
            if (!OrderUtils.isReturnPoint(nextPoint.type)) {
              return nextPoint;
            }
          }
        }
      }
    }
    return null;
  }

  static String getCurrencyText(dynamic? money) {
    return NumberFormat.currency(locale: 'vi', name: 'đ', decimalDigits: 0)
        .format(money);
  }

  static double round(double value, int places) {
    final factor = pow(10, places);
    value = value * factor;
    final tmp = value.round();
    return tmp / factor;
  }

  static bool isIncidentPoint(int? orderStatus, int? pointStatus) {
    if (orderStatus == null || pointStatus == null) {
      return false;
    }

    switch (orderStatus) {
      case OrderStatus.INCIDENT:
      case OrderStatus.IN_PROGRESS_INCIDENT:
        switch (pointStatus) {
          case PointStatus.POINT_INCIDENT_NEW:
          case PointStatus.POINT_INCIDENT_ACCEPT:
          case PointStatus.POINT_ARRIVED:
            return true;
          default:
            return false;
        }
      default:
        return false;
    }
  }

  static bool isFindingOrder(int? status) {
    return status == OrderStatus.FINDING;
  }

  static bool isCancelOrder(int? status) {
    switch (status) {
      case OrderStatus.CANCELED_ADMIN:
      case OrderStatus.CANCELED_PARTNER:
      case OrderStatus.CANCELED_USER:
        return true;
      default:
        return false;
    }
  }

  static bool isProcessOrder(int? status) {
    switch (status) {
      case OrderStatus.ACCEPTED:
      case OrderStatus.IN_PROGRESS:
      case OrderStatus.RETURNING:
      case OrderStatus.INCIDENT:
      case OrderStatus.IN_PROGRESS_INCIDENT:
        return true;
      default:
        return false;
    }
  }

  static bool isCompleteOrder(int? status) {
    return status == OrderStatus.FINISHED ||
        status == OrderStatus.FINISHED_RETURNED;
  }

  static bool isInstallFailedOrder(int? status) {
    return status == OrderStatus.INSTALL_FAILED;
  }

  static bool isPendingOrder(int? status) {
    return status == OrderStatus.WAITING_CONFIRM;
  }

  static String? collectExternalCode(OrderModel? order, String? pickPointId) {
    StringBuffer result = new StringBuffer();

    if (order != null &&
        order.detail != null &&
        order.detail?.points != null &&
        pickPointId != null) {
      for (final point in order.detail!.points!) {
        if ((point.type == PointType.DELIVERY_POINT ||
                point.type == PointType.DELIVERY_INSTALLATION_POINT) &&
            point.pickPointId == pickPointId &&
            (point.externalCode != null && point.externalCode!.isNotEmpty)) {
          result.write('${point.externalCode},');
        }
      }

      if (result.length > 0) {
        return result.toString().substring(0, result.length - 1);
      }
    }

    return result.toString();
  }

  static String? collectExternalCodeProduct(List<PickPointProductModel>? productModels){
    StringBuffer result = new StringBuffer();
    if(productModels != null){
      for(final pickPointProductModel in productModels){
        result.write('${pickPointProductModel.externalCode}, ');
      }
    }

    if (result.length > 0) {
      result.toString().substring(result.length - 1);
    }
    if (result.length > 0) {
      result.toString().substring(result.length - 1);
    }
    return result.toString();

  }

  static List<PickPointProductModel> collectProducts(OrderModel? orderModel, Point? pointCurrent) {
    List<PickPointProductModel> result = [];

    List<Point>? points = orderModel?.detail?.points;
    if (points != null) {
      for (final point in points) {
        if (point.pickPointId == pointCurrent?.id) {
          switch (point.type) {
            case PointType.DELIVERY_POINT:
            case PointType.DELIVERY_INSTALLATION_POINT:
              List<ProductModel> pointProducts = [];
              if (point.products != null) {
                pointProducts.addAll(point.products!);
              }
              if (point.returnedProducts != null) {
                pointProducts.addAll(point.returnedProducts!);
              }

              List<ProductModel> products = [];
              for (ProductModel pointProduct in pointProducts) {
                if (!_isContained(pointProduct, result, products)) {
                  products.add(pointProduct);
                }
              }
              if (products.isNotEmpty)
                result.add(PickPointProductModel(
                    pointId: point.id,
                    externalCode: point.externalCode,
                    name: point.contact?.name,
                    products: products));
          }
        }
      }
    }
    return result;
  }

  static bool _isContained(ProductModel product,
      List<PickPointProductModel> relatePoints, List<ProductModel> products) {
    for (final relatePoint in relatePoints) {
      if (relatePoint.products != null) {
        for (final pointProduct in relatePoint.products!) {
          if (pointProduct.id == product.id) {
            int quantity =
                (pointProduct.quantity ?? 0) + (product.quantity ?? 0);
            pointProduct.quantity = quantity;
            return true;
          }
        }
      }
    }

    for (final pointProduct in products) {
      if (pointProduct.id == product.id) {
        int quantity = (pointProduct.quantity ?? 0) + (product.quantity ?? 0);
        pointProduct.quantity = quantity;
        return true;
      }
    }

    return false;
  }
}
