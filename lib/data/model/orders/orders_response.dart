
import 'package:tms_partner_app/base/base_page_list.dart';
import 'package:tms_partner_app/utils/prefs_util.dart';

import '../models.dart';

class OrdersResponse extends BasePageList {
  List<OrderModel>? data;
  String? message;
  int? errorCode;

  OrdersResponse({this.data, this.errorCode, this.message});

  OrdersResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    data = json['data'] != null
        ? List<OrderModel>.from(json['data'].map((x) => OrderModel.fromJson(x)))
        : null;
  }
}

class OrderModel {
  OrderModel(
      {this.id,
      this.serviceId,
      this.returnAtWarehouse,
      this.deliveryType,
      this.servicerCost,
      this.promotionCode,
      this.paymentMethod,
      this.payer,
      this.serviceType,
      this.userId,
      this.expectedTime,
      this.note,
      this.cod,
      this.costDetail,
      this.servicerCostDetail,
      this.realCost,
      this.serviceCost,
      this.externalCode,
      this.packages,
      this.deliveryOrder,
      this.detail,
      this.status,
      this.createdAt,
      this.code,
      this.acceptedAt,
      this.finishedAt,
      this.serviceName,
      this.icon,
      this.statusLabel,
      this.remainingPrePaid,
      this.reach,
      this.cancelReason,
      this.conversationBadges,
      this.serialNumbers,
      this.prePaid,
      this.weight,
      this.size,
      this.groups,
      this.parentOrderId,
      required this.isChildOrder,
      required this.expandGroup,
      required this.countSO,
      this.groupPoints,
      this.errorCode,
      this.message});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json['_id'],
        code: json['code'],
        deliveryType: json['deliveryType'],
        servicerCost: checkDouble(json['servicerCost']),
        promotionCode: json['promotionCode'],
        paymentMethod: json['paymentMethod'],
        payer: json['payer'] != null
            ? List<PayerService>.from(
                json['payer'].map((x) => PayerService.fromJson(x)))
            : null,
        serviceType: json['serviceType'],
        status: json['status'],
        detail: json['detail'] != null
            ? DetailModel.fromJson(json['detail'])
            : null,
        createdAt: json['createdAt'],
        reach: json['reach'] != null ? Reach.fromJson(json['reach']) : null,
        serviceName: json['serviceName'],
        statusLabel: json['statusLabel'],
        servicerCostDetail: json['serviceCostDetail'] != null
            ? List<ServiceCostDetail>.from(json['serviceCostDetail']
                .map((x) => ServiceCostDetail.fromJson(x)))
            : null,
        costDetail: json['costDetail'] != null
            ? List<CostDetail>.from(
                json['costDetail'].map((x) => CostDetail.fromJson(x)))
            : null,
        note: json['note'],
        serviceId: json['servicerId'],
        cancelReason: json['cancelReason'],
        userId: json['userId'],
        acceptedAt: json['acceptedAt'],
        finishedAt: json['finishedAt'],
        conversationBadges: json['conversations'] != null
            ? List<ConversationBadge>.from(
                json['conversations'].map((x) => ConversationBadge.fromJson(x)))
            : null,
        serialNumbers: json['products'] != null
            ? List<SerialNumber>.from(
                json['products'].map((x) => SerialNumber.fromJson(x)))
            : null,
        prePaid: checkDouble(json['prePaid']),
        externalCode: json['externalCode'],
        expectedTime: json['expectedTime'],
        returnAtWarehouse: json['returnAtWarehouse'],
        weight: checkDouble(json['weight']),
        size: json['size'] != null ? SizeModel.fromJson(json['size']) : null,
        cod: json['cod'] != null ? Cod.fromJson(json['cod']) : null,
        realCost: json['realCost'],
        serviceCost: json['serviceCost'],
        packages: json['packages'] != null
            ? Packages.fromJson(json['packages'])
            : null,
        deliveryOrder: json['deliveryOrder'],
        icon: json['icon'],
        remainingPrePaid: json['remainingPrePaid'],
        isChildOrder: false,
        expandGroup: false,
        countSO: 1,
        errorCode: json['errorCode'],
        message: json['message']);
  }

  bool isGrouped() {
    if (this.groups == null) {
      return false;
    }
    return this.groups!.length > 1;
  }

  Packages getPackageInGroup() {
    int total = 0;
    List<String> packageList = [];
    if (this.groups != null) {
      this.groups?.forEach((orderGroup) {
        if (orderGroup.packages != null &&
            orderGroup.packages?.packageList != null &&
            orderGroup.packages?.totalPackage != null &&
            orderGroup.packages!.totalPackage! > 0) {
          total = total + orderGroup.packages!.totalPackage!;
          packageList.addAll(orderGroup.packages!.packageList!);
        } else {
          total++;
          if (orderGroup.externalCode != null) {
            packageList.add(orderGroup.externalCode!);
          }
        }
      });
    }
    return Packages(packageList: packageList, totalPackage: total);
  }

  String? id;
  String? code;
  String? deliveryType;
  double? servicerCost;
  String? promotionCode;
  String? paymentMethod;
  List<PayerService>? payer;
  String? serviceType;
  int? status;
  DetailModel? detail;
  int? createdAt;
  Reach? reach;
  String? serviceName;
  String? statusLabel;
  List<ServiceCostDetail>? servicerCostDetail;
  List<CostDetail>? costDetail;
  String? note;
  String? serviceId;
  String? icon;
  String? cancelReason;
  String? userId;
  int? acceptedAt;
  int? finishedAt;
  List<ConversationBadge>? conversationBadges;
  List<SerialNumber>? serialNumbers;
  double? prePaid;
  String? externalCode;
  int? expectedTime;
  bool? returnAtWarehouse;
  double? weight;
  SizeModel? size;
  Cod? cod;
  int? realCost;
  int? serviceCost;
  Packages? packages;
  String? deliveryOrder;
  int? remainingPrePaid;
  List<OrderGroup>? groups = [];
  String? parentOrderId;
  bool isChildOrder;
  bool expandGroup;
  int countSO;
  List<OrderGroupPoint>? groupPoints;
  String? message;
  int? errorCode;
}
