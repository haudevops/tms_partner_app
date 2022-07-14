

import 'package:tms_partner_app/utils/prefs_util.dart';

class PointCostDetail {
  PointCostDetail({
    this.name,
    this.style,
    this.payer,
    this.cost,
    this.userCost,
    this.baseUserCost,
    this.serviceCost,
    this.commission,
    this.distance,
    this.price,
  });

  factory PointCostDetail.fromJson(Map<String, dynamic> json) {
    return PointCostDetail(
      name: json['name'],
      style: json['style'],
      payer: json['payer'],
      cost: json['cost'],
      userCost: json['userCost'],
      baseUserCost: json['baseUserCost'],
      serviceCost: json['servicerCost'],
      commission: json['commission'],
      price: json['price'],
      distance: checkDouble(json['distance']),
    );
  }

  String? name;
  int? style;
  String? payer;
  int? cost;
  int? userCost;
  int? baseUserCost;
  int? serviceCost;
  int? commission;
  double? distance;
  int? price;
}
