
import 'package:tms_partner_app/utils/common_utils/object_util.dart';

class PayerService {
  PayerService({this.name, this.style, this.payer, this.cost});

  factory PayerService.fromJson(Map<String, dynamic> json) {
    return PayerService(
      name: json['name'],
      style: json['style'],
      payer: json['payer'],
      cost: checkDouble(json['payer']),
    );
  }

  String? name;
  int? style;
  String? payer;
  double? cost;
}
