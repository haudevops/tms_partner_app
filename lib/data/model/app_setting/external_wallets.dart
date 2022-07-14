class ExternalWallets {
  ExternalWallets({required this.vnpay});

  factory ExternalWallets.fromJson(Map<String, dynamic> json) {
    return ExternalWallets(vnpay: json['vnpay'] ?? false);
  }

  Map<String, dynamic> toJson() => {'vnpay': vnpay};

  bool vnpay;
}
