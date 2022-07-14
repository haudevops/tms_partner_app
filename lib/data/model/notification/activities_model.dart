
import 'package:tms_partner_app/base/base_page_list.dart';

class ActivitiesModel extends BasePageList {
  List<ActivityModel>? data;
  String? message;
  int? errorCode;

  ActivitiesModel({this.data, this.errorCode, this.message});

  ActivitiesModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    data = json['data'] != null
        ? List<ActivityModel>.from(
            json['data'].map((x) => ActivityModel.fromJson(x)))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivityModel {
  String? id;
  String? orderId;
  String? orderCode;
  String? type;
  String? userId;
  String? servicerId;
  String? reason;
  bool? seen;
  String? groupId;
  int? createdAt;
  int? updatedAt;
  String? orderCodeTitle;
  String? partnerNote;
  String? note;
  String? name;

  ActivityModel(
      {this.id,
      this.orderId,
      this.orderCode,
      this.type,
      this.userId,
      this.servicerId,
      this.reason,
      this.seen,
      this.groupId,
      this.createdAt,
      this.updatedAt,
      this.orderCodeTitle,
      this.partnerNote,
      this.note,
      this.name});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    orderId = json['orderId'];
    orderCode = json['orderCode'];
    type = json['type'];
    userId = json['userId'];
    servicerId = json['servicerId'];
    reason = json['reason'];
    seen = json['seen'];
    groupId = json['groupId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    orderCodeTitle = json['orderCodeTitle'];
    partnerNote = json['partnerNote'];
    note = json['note'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['orderId'] = this.orderId;
    data['orderCode'] = this.orderCode;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['servicerId'] = this.servicerId;
    data['reason'] = this.reason;
    data['seen'] = this.seen;
    data['groupId'] = this.groupId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['orderCodeTitle'] = this.orderCodeTitle;
    data['partnerNote'] = this.partnerNote;
    data['note'] = this.note;
    data['name'] = this.name;
    return data;
  }
}
