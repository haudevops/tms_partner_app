class AndroidVersion {
  AndroidVersion({this.require, this.current, this.changeLogs});

  factory AndroidVersion.fromJson(Map<String, dynamic> json) {
    return AndroidVersion(
        require: json['require'],
        current: json['current'],
        changeLogs: json['changeLogs']);
  }

  Map<String, dynamic> toJson() =>
      {'require': require, 'current': current, 'changeLogs': changeLogs};

  int? require;
  int? current;
  String? changeLogs;
}
