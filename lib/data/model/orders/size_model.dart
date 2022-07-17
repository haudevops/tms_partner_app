

import 'package:tms_partner_app/utils/common_utils/object_util.dart';

class SizeModel {
  SizeModel({
    this.width,
    this.height,
    this.length,
    this.volume,
  });

  factory SizeModel.fromJson(Map<String, dynamic> json) {
    return SizeModel(
      width: checkDouble(json['width']),
      height: checkDouble(json['height']),
      length: checkDouble(json['length']),
      volume: checkDouble(json['volume']),
    );
  }

  double? width;
  double? height;
  double? length;
  double? volume;
}
