class CloudResponse {
  String? message;
  int? errorCode;
  List<CloudData>? data;

  CloudResponse({this.message, this.errorCode, this.data});

  factory CloudResponse.fromJson(Map<String, dynamic> json) {
    return CloudResponse(
      data: json['data'] != null
          ? List<CloudData>.from(json['data'].map((x) => CloudData.fromJson(x)))
          : null,
      errorCode: json['errorCode'],
      message: json['message'],
    );
  }
}

class CloudData {
  String? path;
  String? name;
  String? fullPath;

  CloudData({this.name, this.path, this.fullPath});

  factory CloudData.fromJson(Map<String, dynamic> json) {
    return CloudData(
        path: json['path'], name: json['name'], fullPath: json['fullPath']);
  }
}
