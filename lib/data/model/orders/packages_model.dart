class Packages {
  Packages({
    this.totalPackage,
    this.packageList,
  });

  factory Packages.fromJson(Map<String, dynamic> json) {
    return Packages(
      totalPackage: json['totalPackage'],
      packageList:
          json['packageList'] != null ? List.from(json['packageList']) : null,
    );
  }

  int? totalPackage;
  List<String>? packageList;
}
