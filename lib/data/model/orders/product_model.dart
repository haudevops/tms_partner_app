

import 'package:tms_partner_app/utils/prefs_util.dart';

import 'size_model.dart';

class ProductModel {
  ProductModel({
    this.name,
    this.sku,
    this.serial,
    this.quantity,
    this.unit,
    this.size,
    this.id,
    this.pointId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        name: json['name'],
        sku: json['sku'],
        serial: json['serial'],
        quantity: json['quantity'],
        unit: json['unit'],
        id: json['id'],
        size: json['size'] != null ? SizeModel.fromJson(json['size']) : null,
        pointId: checkDouble(json['pointId']));
  }

  String? name;
  String? sku;
  String? serial;
  int? quantity;
  String? unit;
  SizeModel? size;
  String? id;
  double? pointId;
}
