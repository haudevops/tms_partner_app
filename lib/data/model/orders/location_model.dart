import 'package:tms_partner_app/utils/common_utils/object_util.dart';

class LocationModel {
  LocationModel({
    this.lat,
    this.lng,
    this.address,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        lat: checkDouble(json['lat']),
        lng: checkDouble(json['lng']),
        address: json['address']);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationModel &&
          runtimeType == other.runtimeType &&
          lat == other.lat &&
          lng == other.lng &&
          address == other.address;

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode ^ address.hashCode;

  double? lat;
  double? lng;
  String? address;
}
