class DeliverySkipReason {
  DeliverySkipReason({this.id, this.name});

  factory DeliverySkipReason.fromJson(Map<String, dynamic> json) {
    return DeliverySkipReason(id: json['_id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'_id': id, 'name': name};

  String? id;
  String? name;
}
