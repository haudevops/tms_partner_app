


import 'package:tms_partner_app/data/model/models.dart';

class ReasonTemplate {
  ReasonTemplate({this.type, this.reasons});

  factory ReasonTemplate.fromJson(Map<String, dynamic> json) {
    return ReasonTemplate(
      type: json['type'],
      reasons: (json['reasons'] != null)
          ? List<ReasonModel>.from(
              json['reasons'].map((x) => ReasonModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'reasons': reasons?.map((e) => e.toJson()).toList(),
      };

  String? type;
  List<ReasonModel>? reasons;
}
