class Vehicles {
  Vehicles(
      {this.typeId,
      this.name,
      this.number,
      this.id,
      this.createdAt,
      this.activeAt});

  factory Vehicles.fromJson(Map<String, dynamic> json) {
    return Vehicles(
      typeId: json['typeId'],
      name: json['name'],
      number: json['number'],
      id: json['_id'],
      createdAt: json['createdAt'],
      activeAt: json['activeAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'typeId': typeId,
        'name': name,
        'number': number,
        '_id': id,
        'createdAt': createdAt,
        'activeAt': activeAt,
      };

  String? typeId;
  String? name;
  String? number;
  String? id;
  int? createdAt;
  int? activeAt;
}
