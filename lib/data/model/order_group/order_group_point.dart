

import '../models.dart';

class OrderGroupPoint {
  OrderGroupPoint(
      {this.id,
      this.externalCode,
      this.location,
      this.status,
      this.products,
      this.type});

  factory OrderGroupPoint.fromJson(Map<String, dynamic> json) {
    return OrderGroupPoint(
      id: json['id'],
      externalCode: json['code'],
      status: json['status'],
      type: json['type'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      products: json['products'] != null
          ? List<ProductModel>.from(
              json['products'].map((x) => ProductModel.fromJson(x)))
          : null,
    );
  }

  String? id;
  String? externalCode;
  LocationModel? location;
  int? status;
  int? type;
  List<ProductModel>? products;
}
