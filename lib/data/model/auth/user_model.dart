

import '../models.dart';
import 'address_model.dart';
import 'settings_model.dart';
import 'teams_model.dart';
import 'vehicles_model.dart';

class ProfileModel {
  ProfileModel(
      {this.id,
      this.type,
      this.fullName,
      this.phone,
      this.email,
      this.identityNumber,
      this.address,
      this.images,
      this.identityCardImages,
      this.driverLicenseImages,
      this.businessCertificateImages,
      this.bank,
      this.groupId,
      this.teamModel,
      this.vehicles,
      this.vehicle,
      this.status,
      this.currency,
      this.serveLevelIds,
      this.rate,
      this.rateTimes,
      this.createdBy,
      this.activeAt,
      this.createdAt,
      this.settings,
      this.code,
      this.numberOfOrders,
      this.limitOrder,
      this.updatedAt,
      this.state,
      this.loyaltyPoint,
      this.userLevelPoint,
      this.willExpiredPoint,
      this.errorCode,
      this.message});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'],
      type: json['type'],
      fullName: json['fullName'],
      phone: json['phone'],
      email: json['email'],
      identityNumber: json['identityNumber'],
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
      images: json['images'] != null ? List.from(json['images']) : null,
      identityCardImages: json['identityCardImages'] != null
          ? List.from(json['identityCardImages'])
          : null,
      driverLicenseImages: json['driverLicenseImages'] != null
          ? List.from(json['driverLicenseImages'])
          : null,
      businessCertificateImages: json['businessCertificateImages'] != null
          ? List.from(json['businessCertificateImages'])
          : null,
      bank: json['bank'] != null ? BankModel.fromJson(json['bank']) : null,
      groupId: json['groupId'],
      teamModel: (json['teams'] != null)
          ? List<TeamModel>.from(
              json['teams'].map((x) => TeamModel.fromJson(x)))
          : null,
      vehicles: (json['vehicles'] != null)
          ? List<Vehicles>.from(
              json['vehicles'].map((x) => Vehicles.fromJson(x)))
          : null,
      vehicle:
          json['vehicle'] != null ? Vehicles.fromJson(json['vehicle']) : null,
      status: json['status'],
      currency: json['currency'],
      serveLevelIds: json['serveLevelIds'] != null
          ? List.from(json['serveLevelIds'])
          : null,
      rate: json['rate'],
      rateTimes: json['rateTimes'],
      createdBy: json['createdBy'],
      activeAt: json['activeAt'],
      createdAt: json['createdAt'],
      settings: json['settings'] != null
          ? SettingsModel.fromJson(json['settings'])
          : null,
      code: json['code'],
      numberOfOrders: json['numberOfOrders'],
      limitOrder: json['limitOrder'],
      updatedAt: json['updatedAt'],
      state: json['state'],
      loyaltyPoint: json['loyaltyPoint'],
      userLevelPoint: json['userLevelPoint'],
      willExpiredPoint: json['willExpiredPoint'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'type': type,
        'fullName': fullName,
        'phone': phone,
        'email': email,
        'identityNumber': identityNumber,
        'address': address?.toJson(),
        'images': images,
        'identityCardImages': identityCardImages,
        'driverLicenseImages': driverLicenseImages,
        'businessCertificateImages': businessCertificateImages,
        'bank': bank?.toJson(),
        'groupId': groupId,
        'teamModel': teamModel?.map((e) => e.toJson()).toList(),
        'vehicles': vehicles?.map((e) => e.toJson()).toList(),
        'vehicle': vehicle?.toJson(),
        'status': status,
        'currency': currency,
        'serveLevelIds': serveLevelIds,
        'rate': rate,
        'rateTimes': rateTimes,
        'createdBy': createdBy,
        'activeAt': activeAt,
        'createdAt': createdAt,
        'settings': settings?.toJson(),
        'code': code,
        'numberOfOrders': numberOfOrders,
        'limitOrder': limitOrder,
        'updatedAt': updatedAt,
        'state': state,
        'loyaltyPoint': loyaltyPoint,
        'userLevelPoint': userLevelPoint,
        'willExpiredPoint': willExpiredPoint,
        'identityNumber': identityNumber,
      };

  String? id;
  int? type;
  String? fullName;
  String? phone;
  String? email;
  String? identityNumber;
  AddressModel? address;
  List<String>? images;
  List<String>? identityCardImages;
  List<String>? driverLicenseImages;
  List<String>? businessCertificateImages;
  BankModel? bank;
  String? groupId;
  List<TeamModel>? teamModel;
  List<Vehicles>? vehicles;
  Vehicles? vehicle;
  int? status;
  String? currency;
  List<String>? serveLevelIds;
  int? rate;
  int? rateTimes;
  String? createdBy;
  int? activeAt;
  int? createdAt;
  SettingsModel? settings;
  String? code;
  int? numberOfOrders;
  int? limitOrder;
  int? updatedAt;
  bool? state;
  int? loyaltyPoint;
  int? userLevelPoint;
  int? willExpiredPoint;
  String? message;
  int? errorCode;
}
