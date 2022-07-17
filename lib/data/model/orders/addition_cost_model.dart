import 'package:tms_partner_app/utils/common_utils/object_util.dart';

class AdditionCost {
  AdditionCost(
      {this.id,
      this.value,
      this.name,
      this.price,
      this.cost,
      this.quantity,
      this.style,
      this.unit});

  factory AdditionCost.fromJson(Map<String, dynamic> json) {
    return AdditionCost(
        id: json['id'],
        value: json['value'],
        name: json['name'],
        price: checkDouble(json['price']),
        cost: checkDouble(json['cost']),
        quantity: checkDouble(json['quantity']),
        style: json['style'],
        unit: json['unit']);
  }

  String? id;
  String? value;
  String? name;
  double? price;
  double? cost;
  double? quantity;
  int? style;
  String? unit;
}
