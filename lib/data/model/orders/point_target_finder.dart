

import 'package:tms_partner_app/data/model/orders/point_model.dart';

class PointTargetFinder {
  PointTargetFinder(
      {this.status,
      this.type,
      this.point,
      this.nexPoint,
      this.currentPointIndex,
      this.nextPointIndex});

  int? status;
  int? type;
  Point? point;
  Point? nexPoint;
  int? currentPointIndex;
  int? nextPointIndex;
}
