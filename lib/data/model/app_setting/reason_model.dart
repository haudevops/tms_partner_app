class ReasonModel {
  ReasonModel({this.name, this.image});

  factory ReasonModel.fromJson(Map<String, dynamic> json) {
    return ReasonModel(name: json['name'], image: json['image']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
      };

  String? name;
  String? image;
}
