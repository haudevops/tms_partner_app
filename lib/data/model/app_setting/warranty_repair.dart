import 'brand_model.dart';

class WarrantyRepair {
  WarrantyRepair({this.brands, this.productTypes});

  factory WarrantyRepair.fromJson(Map<String, dynamic> json) {
    return WarrantyRepair(
        brands: (json['brands'] != null)
            ? List<Brand>.from(json['brands'].map((x) => Brand.fromJson(x)))
            : null,
        productTypes: (json['productTypes'] != null)
            ? List<Brand>.from(
                json['productTypes'].map((x) => Brand.fromJson(x)))
            : null);
  }

  Map<String, dynamic> toJson() => {
        'brands': brands?.map((e) => e.toJson()).toList(),
        'productTypes': productTypes?.map((e) => e.toJson()).toList(),
      };

  List<Brand>? brands;
  List<Brand>? productTypes;
}
