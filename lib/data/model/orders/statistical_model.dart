class StatisticalModel {
  StatisticalModel({this.message, this.errorCode, this.finished, this.current});

  factory StatisticalModel.fromJson(Map<String, dynamic> json) {
    return StatisticalModel(
        message: '',
        errorCode: 0,
        finished: json['finished'],
        current: json['current']);
  }

  String? message;
  int? errorCode;
  int? finished;
  int? current;
}
