

import '../models.dart';

class AppSettingModel {
  AppSettingModel(
      {this.general,
      this.installation,
      this.delivery,
      this.warrantyRepair,
      this.reasonTemplates,
      this.message,
      this.errorCode});

  factory AppSettingModel.fromJson(Map<String, dynamic> json) {
    return AppSettingModel(
      general: json['general'] != null
          ? GeneralModel.fromJson(json['general'])
          : null,
      installation: json['installation'] != null
          ? Installation.fromJson(json['installation'])
          : null,
      delivery:
          json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null,
      warrantyRepair: json['warrantyRepair'] != null
          ? WarrantyRepair.fromJson(json['warrantyRepair'])
          : null,
      reasonTemplates: (json['reasonTemplates'] != null)
          ? List<ReasonTemplate>.from(
              json['reasonTemplates'].map((x) => ReasonTemplate.fromJson(x)))
          : null,
      message: json['message'],
      errorCode: 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'general': general?.toJson(),
        'installation': installation?.toJson(),
        'delivery': delivery?.toJson(),
        'warrantyRepair': warrantyRepair?.toJson(),
        'reasonTemplates': reasonTemplates?.map((e) => e.toJson()).toList(),
      };

  GeneralModel? general;
  Installation? installation;
  Delivery? delivery;
  WarrantyRepair? warrantyRepair;
  List<ReasonTemplate>? reasonTemplates;
  String? message;
  int? errorCode;
}

class GeneralModel {
  GeneralModel(
      {this.callCenterPhone,
      this.customerServicePhone,
      this.bankAccounts,
      this.codBanks,
      this.appVersion,
      this.adminAvatar,
      this.externalWallets});

  factory GeneralModel.fromJson(Map<String, dynamic> json) {
    return GeneralModel(
      callCenterPhone: json['callCenterPhone'],
      customerServicePhone: json['customerServicePhone'],
      bankAccounts: (json['bankAccounts'] != null)
          ? List<BankModel>.from(
              json['bankAccounts'].map((x) => BankModel.fromJson(x)))
          : null,
      codBanks: (json['codBanks'] != null)
          ? List<Bank>.from(json['codBanks'].map((x) => Bank.fromJson(x)))
          : null,
      appVersion: json['androidAppVersion'] != null
          ? AndroidVersion.fromJson(json['androidAppVersion'])
          : null,
      adminAvatar: json['adminAvatar'],
      externalWallets: json['externalWallets'] != null
          ? ExternalWallets.fromJson(json['externalWallets'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'callCenterPhone': callCenterPhone,
        'customerServicePhone': customerServicePhone,
        'bankAccounts': bankAccounts?.map((e) => e.toJson()).toList(),
        'codBanks': codBanks?.map((e) => e.toJson()).toList(),
        'appVersion': appVersion?.toJson(),
        'adminAvatar': adminAvatar,
        'externalWallets': externalWallets?.toJson(),
      };

  String? callCenterPhone;
  String? customerServicePhone;
  List<BankModel>? bankAccounts;
  List<Bank>? codBanks;
  AndroidVersion? appVersion;
  String? adminAvatar;
  ExternalWallets? externalWallets;
}
