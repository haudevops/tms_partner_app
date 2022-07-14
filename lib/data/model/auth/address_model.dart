class AddressModel {
  AddressModel(
      {this.street,
      this.cityId,
      this.districtId,
      this.ward,
      this.city,
      this.district,
      this.cityName,
      this.districtName});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'],
      cityId: json['cityId'],
      districtId: json['districtId'],
      ward: json['ward'],
      city: json['city'],
      district: json['district'],
      cityName: json['cityName'],
      districtName: json['districtName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'street': street,
        'cityId': cityId,
        'districtId': districtId,
        'ward': ward,
        'city': city,
        'district': district,
        'cityName': cityName,
        'districtName': districtName,
      };

  String? street;
  String? cityId;
  String? districtId;
  String? ward;
  String? city;
  String? district;
  String? cityName;
  String? districtName;
}
