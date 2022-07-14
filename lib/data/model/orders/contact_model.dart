class Contact {
  Contact({
    this.name,
    this.phone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      phone: json['phone'],
    );
  }

  String? name;
  String? phone;
}
