class SerialNumber {
  SerialNumber({this.serialNumber, this.quantity});

  factory SerialNumber.fromJson(Map<String, dynamic> json) {
    return SerialNumber(
        serialNumber: json['serialNumber'], quantity: json['quantity']);
  }

  String? serialNumber;
  int? quantity;
}
