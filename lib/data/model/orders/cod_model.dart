class Cod {
  Cod({
    this.total,
    this.remaining,
    this.requestStatus,
  });

  factory Cod.fromJson(Map<String, dynamic> json) {
    return Cod(
        total: json['total'],
        remaining: json['remaining'],
        requestStatus: json['requestStatus']);
  }

  int? total;
  int? remaining;
  int? requestStatus;
}
