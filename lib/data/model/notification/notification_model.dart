class NotificationModel {
  String? id;
  int? point;
  String? orderId;
  String? orderCode;
  String? type;
  String? servicerId;
  bool? seen;
  int? createdAt;
  int? updatedAt;
  String? orderCodeTitle;
  String? partnerNote;
  String? reason;
  String? note;
  String? name;

  NotificationModel(
      {this.id,
      this.point,
      this.orderId,
      this.orderCode,
      this.type,
      this.servicerId,
      this.seen,
      this.createdAt,
      this.updatedAt,
      this.orderCodeTitle,
      this.partnerNote,
      this.reason,
      this.note,
      this.name});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      point: json['point'],
      orderId: json['orderId'],
      orderCode: json['orderCode'],
      type: json['type'],
      servicerId: json['servicerId'],
      seen: json['seen'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      orderCodeTitle: json['orderCodeTitle'],
      partnerNote: json['partnerNote'],
      reason: json['reason'],
      note: json['note'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['point'] = this.point;
    data['orderId'] = this.orderId;
    data['orderCode'] = this.orderCode;
    data['type'] = this.type;
    data['servicerId'] = this.servicerId;
    data['seen'] = this.seen;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['orderCodeTitle'] = this.orderCodeTitle;
    data['partnerNote'] = this.partnerNote;
    data['reason'] = this.reason;
    data['note'] = this.note;
    data['name'] = this.name;
    return data;
  }
}
