
import 'package:tms_partner_app/utils/order/business_constant.dart';
import 'package:tms_partner_app/utils/order/order_utils.dart';
import 'package:tms_partner_app/utils/order/point_status_enum.dart';
import 'package:tms_partner_app/utils/common_utils/object_util.dart';

import '../models.dart';

class DetailModel {
  DetailModel({
    this.distance,
    this.vehicleTypeId,
    this.points,
    this.vehicle,
    this.goodsCheckRequired,
    this.images,
    this.weight,
    this.note,
    this.catId,
    this.driverPriority,
    this.groupedPoints,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      goodsCheckRequired: json['goodsCheckRequired'],
      distance: checkDouble(json['distance']),
      vehicleTypeId: json['vehicleTypeId'],
      points: json['points'] != null
          ? List<Point>.from(json['points'].map((x) => Point.fromJson(x)))
          : null,
      vehicle:
          json['vehicle'] != null ? Vehicles.fromJson(json['vehicle']) : null,
      images: json['images'] != null ? List.from(json['images']) : null,
      weight: json['weight'],
      note: json['note'],
      catId: json['catId'],
      driverPriority: json['driverPriority'],
    );
  }

  bool? goodsCheckRequired;
  double? distance;
  String? vehicleTypeId;
  List<Point>? points;
  Vehicles? vehicle;
  List<String>? images;
  int? weight;
  String? note;
  String? catId;
  bool? driverPriority;
  List<Point>? groupedPoints;

  bool isMultiPickPoint() {
    int countPickPoint = 0;
    if (points == null) {
      return false;
    }
    for (Point pointInfo in points!) {
      if (pointInfo.type == PointType.PICK_POINT) {
        countPickPoint++;
      }
    }
    return countPickPoint > 1;
  }

  Point? getNextPointProgress(String? pointIDCurrent) {
    if (points != null && points!.length > 1) {
      List<Point> points = getListPointNeedExecute(pointIDCurrent);
      for (final nextPoint in points) {
        if (pointIDCurrent != nextPoint.id) {
          if (!OrderUtils.isReturnPoint(nextPoint.type)) {
            return nextPoint;
          }
        }
      }
      return null;
    }
    return null;
  }

  List<Point> getListPointNeedExecute(String? pointID) {
    List<Point> results = [];
    if (pointID != null && points != null) {
      for (final pointInfo in points!) {
        if (pointInfo.id != pointID) {
          if (OrderUtils.isDeliveryProgressPoint(
              status: pointInfo.status, type: pointInfo.type)) {
            Point? pickPoint = getPickPointByPointID(pointInfo.pickPointId);
            if (pickPoint != null &&
                pickPoint.status == PointStatusEnum.PICK_SUCCESS.status)
              results.add(pointInfo);
          } else {
            if (!OrderUtils.ignorePoint(pointInfo.status,
                pointInfo.type)) if (!OrderUtils.isReturnPoint(pointInfo.type))
              results.add(pointInfo);
          }
        }
      }
    }
    return results;
  }

  Point? getPickPointByPointID(String? pickPointID) {
    if (pickPointID != null && points != null) {
      for (final pointPickup in points!) {
        if (OrderUtils.isPickPoint(pointPickup.type)) {
          if (pickPointID == pointPickup.id) {
            return pointPickup;
          }
        }
      }
      return null;
    }
    return null;
  }
}
