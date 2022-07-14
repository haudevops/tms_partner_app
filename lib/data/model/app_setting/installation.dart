

import '../orders/service_model.dart';

class Installation {
  Installation({this.addonServices});

  factory Installation.fromJson(Map<String, dynamic> json) {
    return Installation(
      addonServices: (json['addonServices'] != null)
          ? List<ServiceModel>.from(
              json['addonServices'].map((x) => ServiceModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {'addonServices': addonServices?.map((e) => e.toJson()).toList()};

  List<ServiceModel>? addonServices;
}
