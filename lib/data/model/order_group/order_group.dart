import '../models.dart';

class OrderGroup {
  OrderGroup(
      {this.id,
      this.externalCode,
      this.servicerCost,
      this.orderCoD,
      this.points,
      this.packages,
      this.deliveryOrder,
      this.expectedTime,
      this.detail,
      this.deliveryType,
      this.code,
      this.status,
      this.serviceName});

  String? id;
  String? externalCode;
  double? servicerCost;
  Cod? orderCoD;
  List<OrderGroupPoint>? points;
  Packages? packages;
  String? deliveryOrder;
  String? deliveryType;
  int? expectedTime;
  DetailModel? detail;
  String? code;
  int? status;
  String? serviceName;
}
