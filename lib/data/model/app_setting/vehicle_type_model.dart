class VehicleType {
  VehicleType(
      {this.id,
      this.name,
      this.imgUrl,
      this.markerIcon,
      this.maxWeight,
      this.markerSmIcon,
      this.selectedImgUrl,
      this.children,
      this.isSelected});

  factory VehicleType.fromJson(Map<String, dynamic> json) {
    return VehicleType(
      id: json['_id'],
      name: json['name'],
      imgUrl: json['imgUrl'],
      markerIcon: json['markerIcon'],
      maxWeight: json['maxWeight'],
      markerSmIcon: json['markerSmIcon'],
      selectedImgUrl: json['selectedImgUrl'],
      children: (json['children'] != null)
          ? List<VehicleType>.from(
              json['children'].map((x) => VehicleType.fromJson(x)))
          : null,
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'imgUrl': imgUrl,
        'markerIcon': markerIcon,
        'maxWeight': maxWeight,
        'markerSmIcon': markerSmIcon,
        'selectedImgUrl': selectedImgUrl,
        'children': children?.map((e) => e.toJson()).toList(),
      };

  String? id;
  String? name;
  String? imgUrl;
  String? markerIcon;
  int? maxWeight;
  String? markerSmIcon;
  String? selectedImgUrl;
  List<VehicleType>? children;
  bool? isSelected;
}
