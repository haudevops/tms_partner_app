import 'package:tms_partner_app/utils/common_utils/object_util.dart';

class CostDetail {
  CostDetail({
    this.name,
    this.style,
    this.value,
    this.userCost,
    this.baseUserCost,
    this.children,
  });

  factory CostDetail.fromJson(Map<String, dynamic> json) {
    return CostDetail(
        name: json['name'],
        style: json['style'],
        value: json['value'],
        userCost: json['userCost'],
        baseUserCost: json['baseUserCost'],
        children: json['children'] != null
            ? List<Children>.from(
                json['children'].map((x) => Children.fromJson(x)))
            : null);
  }

  String? name;
  int? style;
  int? value;
  int? userCost;
  int? baseUserCost;
  List<Children>? children;
}

class Children {
  Children({
    this.name,
    this.style,
    this.value,
    this.userCost,
    this.baseUserCost,
    this.distance,
    this.price,
  });

  factory Children.fromJson(Map<String, dynamic> json) {
    return Children(
      name: json['name'],
      style: json['style'],
      value: json['value'],
      userCost: json['userCost'],
      baseUserCost: json['baseUserCost'],
      distance: checkDouble(json['distance']),
      price: json['price'],
    );
  }

  String? name;
  int? style;
  int? value;
  int? userCost;
  int? baseUserCost;
  double? distance;
  int? price;
}
