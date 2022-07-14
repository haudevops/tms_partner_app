import '../models.dart';

class PickPointProductModel {
  PickPointProductModel(
      {this.pointId, this.name, this.externalCode, this.products});

  factory PickPointProductModel.fromJson(Map<String, dynamic> json) {
    return PickPointProductModel(
      pointId: '',
      name: '',
      externalCode: json['externalCode'],
      products: json['products'] != null
          ? List<ProductModel>.from(
              json['products'].map((x) => ProductModel.fromJson(x)))
          : null,
    );
  }

  String? pointId;
  String? name;
  String? externalCode;
  List<ProductModel>? products;
}
