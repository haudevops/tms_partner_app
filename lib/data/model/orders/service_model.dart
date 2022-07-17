

import 'package:tms_partner_app/utils/common_utils/object_util.dart';

class ServiceModel {
  ServiceModel({
    this.price,
    this.style,
    this.id,
    this.value,
    this.status,
    this.cost,
    this.baseUserCost,
    this.serviceCost,
    this.commission,
    this.payer,
    this.name,
    this.type,
    this.distance,
    this.posStart,
    this.vehicleTypeId,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      price: json['price'],
      style: json['style'],
      id: json['_id'],
      value: checkDouble(json['value']),
      status: json['status'],
      cost: json['cost'],
      baseUserCost: json['baseUserCost'],
      serviceCost: json['servicerCost'],
      commission: json['commission'],
      payer: json['payer'],
      name: json['name'],
      type: json['type'],
      distance: checkDouble(json['distance']),
      posStart: checkDouble(json['posStart']),
      vehicleTypeId: json['vehicleTypeId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'price': price,
        'style': style,
        '_id': id,
        'value': value,
        'status': status,
        'cost': cost,
        'baseUserCost': baseUserCost,
        'servicerCost': serviceCost,
        'commission': commission,
        'payer': payer,
        'name': name,
        'type': type,
        'distance': distance,
        'posStart': posStart,
        'vehicleTypeId': vehicleTypeId,
      };

  int? price;
  int? style;
  String? id;
  double? value;
  int? status;
  int? cost;
  int? baseUserCost;
  int? serviceCost;
  int? commission;
  String? payer;
  String? name;
  int? type;
  double? distance;
  double? posStart;
  String? vehicleTypeId;
}
