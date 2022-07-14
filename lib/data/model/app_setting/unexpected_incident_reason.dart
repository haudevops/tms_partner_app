class UnexpectedIncidentReason {
  UnexpectedIncidentReason({this.id, this.type, this.title});

  factory UnexpectedIncidentReason.fromJson(Map<String, dynamic> json) {
    return UnexpectedIncidentReason(
      id: json['_id'],
      type: json['type'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {'_id': id, 'type': type, 'title': title};

  String? id;
  int? type;
  String? title;
}
