

import 'package:tms_partner_app/utils/common_utils/object_util.dart';

import '../models.dart';

class Point {
  Point({
    this.type,
    this.contact,
    this.location,
    this.externalCode,
    this.note,
    this.services,
    this.products,
    this.storeCode,
    this.scanStore,
    this.distance,
    this.posStart,
    this.posEnd,
    this.suggestDuration,
    this.status,
    this.costDetail,
    this.id,
    this.realCost,
    this.userCost,
    this.paid,
    this.expectedTime,
    this.pickPointId,
    this.arrivedAt,
    this.realLocation,
    this.finishedAt,
    this.images,
    this.partnerNote,
    this.pickupLocation,
    this.signImage,
    this.estimateDuration,
    this.additionCost,
    this.deliveryLocation,
    this.unexpectedIncidents,
    this.pointIndex,
    this.remainingPrePaid,
    this.returnedPoints,
    this.returnedProducts,
  });

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      type: json['type'],
      contact:
          json['contact'] != null ? Contact.fromJson(json['contact']) : null,
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      externalCode: json['externalCode'],
      note: json['note'],
      services: json['services'] != null
          ? List<ServiceModel>.from(
              json['services'].map((x) => ServiceModel.fromJson(x)))
          : null,
      products: json['products'] != null
          ? List<ProductModel>.from(
              json['products'].map((x) => ProductModel.fromJson(x)))
          : null,
      storeCode: json['storeCode'],
      scanStore: json['scanStore'],
      distance: checkDouble(json['distance']),
      posStart: checkDouble(json['posStart']),
      posEnd: checkDouble(json['posEnd']),
      suggestDuration: json['suggestDuration'],
      status: json['status'],
      costDetail: json['costDetail'] != null
          ? List<PointCostDetail>.from(
              json['costDetail'].map((x) => PointCostDetail.fromJson(x)))
          : null,
      id: json['id'],
      realCost: json['realCost'],
      userCost: checkDouble(json['userCost']),
      paid: json['paid'],
      expectedTime: json['expectedTime'],
      pickPointId: json['pickPointId'],
      arrivedAt: json['arrivedAt'],
      realLocation: json['realLocation'] != null
          ? LocationModel.fromJson(json['realLocation'])
          : null,
      finishedAt: json['finishedAt'],
      images: json['images'] != null ? List.from(json['images']) : null,
      partnerNote: json['partnerNote'],
      pickupLocation: json['pickupLocation'] != null
          ? LocationModel.fromJson(json['pickupLocation'])
          : null,
      estimateDuration: json['estimateDuration'],
      additionCost: json['additionCost'] != null
          ? List<AdditionCost>.from(
              json['additionCost'].map((x) => AdditionCost.fromJson(x)))
          : null,
      deliveryLocation: json['deliveryLocation'] != null
          ? LocationModel.fromJson(json['deliveryLocation'])
          : null,
      unexpectedIncidents: json['unexpectedIncidents'] != null
          ? List<IncidentModel>.from(
              json['unexpectedIncidents'].map((x) => IncidentModel.fromJson(x)))
          : null,
      returnedPoints: json['returnedPoints'] != null
          ? List<PickPointProductModel>.from(
          json['returnedPoints'].map((x) => PickPointProductModel.fromJson(x)))
          : null,
      returnedProducts: json['returnedProducts'] != null
          ? List<ProductModel>.from(
          json['returnedProducts'].map((x) => ProductModel.fromJson(x)))
          : null,
      pointIndex: json['pointIndex'],
      remainingPrePaid: checkDouble(json['remainingPrePaid']),
      signImage: json['signImage']
    );
  }

  int? type;
  Contact? contact;
  LocationModel? location;
  String? externalCode;
  String? note;
  List<ServiceModel>? services;
  List<ProductModel>? products;
  List<PickPointProductModel>? returnedPoints;
  List<ProductModel>? returnedProducts;
  String? storeCode;
  bool? scanStore;
  double? distance;
  double? posStart;
  double? posEnd;
  int? suggestDuration;
  int? status;
  List<PointCostDetail>? costDetail;
  String? id;
  int? realCost;
  double? userCost;
  int? paid;
  int? expectedTime;
  String? pickPointId;
  int? arrivedAt;
  LocationModel? realLocation;
  int? finishedAt;
  List<String>? images;
  String? partnerNote;
  LocationModel? pickupLocation;
  String? signImage;
  int? estimateDuration;
  List<AdditionCost>? additionCost;
  LocationModel? deliveryLocation;
  List<IncidentModel>? unexpectedIncidents;
  int? pointIndex;
  double? remainingPrePaid;
}
