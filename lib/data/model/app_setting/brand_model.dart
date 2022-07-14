class Brand {
  Brand({this.id, this.name, this.image});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(id: json['_id'], image: json['image'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'_id': id, 'image': image, 'name': name};

  String? id;
  String? name;
  String? image;
}
