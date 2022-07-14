class BankModel {
  BankModel(
      {this.agency,
      this.customerName,
      this.accountNumber,
      this.bankCode,
      this.bankName});

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      agency: json['agency'],
      customerName: json['customerName'],
      accountNumber: json['accountNumber'],
      bankCode: json['code'],
      bankName: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'agency': agency,
        'customerName': customerName,
        'accountNumber': accountNumber,
        'bankCode': bankCode,
        'bankName': bankName,
      };

  String? agency;
  String? customerName;
  String? accountNumber;
  String? bankCode;
  String? bankName;
}

class Bank {
  Bank({this.id, this.code, this.name});

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(id: json['_id'], code: json['code'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'_id': id, 'code': code, 'name': name};

  String? id;
  String? code;
  String? name;
}
