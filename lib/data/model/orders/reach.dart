class Reach {
  Reach({this.summary});

  factory Reach.fromJson(Map<String, dynamic> json) {
    return Reach(
      summary: json['name'] != null ? List.from(json['name']) : null,
    );
  }

  List<String>? summary;
}
