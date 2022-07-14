import 'cost_detail_model.dart';

class ServiceCostDetail {
  ServiceCostDetail({
    this.name,
    this.style,
    this.value,
    this.children,
  });

  factory ServiceCostDetail.fromJson(Map<String, dynamic> json) {
    return ServiceCostDetail(
      name: json['name'],
      style: json['style'],
      value: json['value'],
      children: json['children'] != null
          ? List<Children>.from(
              json['children'].map((x) => Children.fromJson(x)))
          : null,
    );
  }

  String? name;
  int? style;
  int? value;
  List<Children>? children;
}
