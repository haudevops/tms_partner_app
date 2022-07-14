class SettingsModel {
  SettingsModel({this.lang, this.powerSaver});

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(lang: json['lang'], powerSaver: json['powerSaver']);
  }

  Map<String, dynamic> toJson() => {'lang': lang, 'powerSaver': powerSaver};

  String? lang;
  bool? powerSaver;
}
