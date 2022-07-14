

import '../models.dart';

class Delivery {
  Delivery(
      {this.vehicleTypes,
      this.unexpectedIncidentReasons,
      this.deliverySkipReasons});

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      vehicleTypes: (json['vehicleTypes'] != null)
          ? List<VehicleType>.from(
              json['vehicleTypes'].map((x) => VehicleType.fromJson(x)))
          : null,
      unexpectedIncidentReasons: (json['unexpectedIncidentReasons'] != null)
          ? List<UnexpectedIncidentReason>.from(
              json['unexpectedIncidentReasons']
                  .map((x) => UnexpectedIncidentReason.fromJson(x)))
          : null,
      deliverySkipReasons: (json['deliverySkipReasons'] != null)
          ? List<DeliverySkipReason>.from(json['deliverySkipReasons']
              .map((x) => DeliverySkipReason.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'vehicleTypes': vehicleTypes?.map((e) => e.toJson()).toList(),
        'unexpectedIncidentReasons':
            unexpectedIncidentReasons?.map((e) => e.toJson()).toList(),
        'deliverySkipReasons':
            deliverySkipReasons?.map((e) => e.toJson()).toList()
      };

  List<VehicleType>? vehicleTypes;
  List<UnexpectedIncidentReason>? unexpectedIncidentReasons;
  List<DeliverySkipReason>? deliverySkipReasons;
}
