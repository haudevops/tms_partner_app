class IncidentModel {
  IncidentModel({this.title, this.detail, this.images});

  factory IncidentModel.fromJson(Map<String, dynamic> json) {
    return IncidentModel(
      title: json['title'],
      detail: json['detail'],
      images: json['images'] != null ? List.from(json['images']) : null,
    );
  }

  String? title;
  String? detail;
  List<String>? images;
}
