class TeamModel {
  TeamModel({this.id, this.name});

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(id: json['_id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'_id': id, 'name': name};

  String? id;
  String? name;
}
