class ConversationBadge {
  ConversationBadge(
      {this.conversationId,
      this.unread,
      this.userType,
      this.fullName,
      this.lastName,
      this.firstName});

  factory ConversationBadge.fromJson(Map<String, dynamic> json) {
    return ConversationBadge(
      conversationId: json['conversationId'],
      unread: json['unread'],
      userType: json['userType'],
      fullName: json['fullName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  String? conversationId;
  int? unread;
  String? userType;
  String? fullName;
  String? firstName;
  String? lastName;
}
