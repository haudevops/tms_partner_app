class ServiceType {
  static const String DELIVERY = "delivery";
  static const String DELIVERY_INSTALL = "deliveryInstallation";
  static const String INSTALL = "installation";
  static const String WARRANTY_REPAIR = "warrantyRepair";
}

class PointStatus {
  static const int PICK_FAILED = -3;
  static const int INSTALL_FAILED = -2;
  static const int DELIVER_FAILED = -1;
  static const int NEW = 0;
  static const int DELIVERED = 1;
  static const int INSTALLED = 2;
  static const int POINT_CANCEL = 3;
  static const int POINT_SKIPPED = 4;
  static const int POINT_INCIDENT_NEW = 5;
  static const int POINT_INCIDENT_ACCEPT = 6;
  static const int POINT_INCIDENT_DONE = 7;
  static const int POINT_ARRIVED = 8;
  static const int RETURNED = 9;
  static const int RETURN_FAILED = 10;
  static const int PICK_SUCCESS = 11;
  static const int AGREE_QUOTATION = 12;
  static const int RETURN_WARRANTY_REPAIR = 13;
  static const int SCHEDULE_WARRANTY_REPAIR = 14;
  static const int ALREADY_SEND_QUOTATION = 15;
  static const int DONE = 16;
  static const int FAIL_WARRANTY_REPAIR = 17;
  static const int IN_PROGRESS = 19;
  static const int LATER = 20;
  static const int PENDING = 21;
}

class PointType {
  static const int PICK_POINT = 1;
  static const int DELIVERY_POINT = 2;
  static const int INSTALLATION_POINT = 3;
  static const int RETURN_POINT = 4;
  static const int RETURN_WAREHOUSE = 5;
  static const int WARRANTY = 6;
  static const int REPAIR = 7;
  static const int CONSULTATION = 8;
  static const int INCIDENT = 9;
  static const int DELIVERY_INSTALLATION_POINT = 11;
}

class OrderStatus {
  static const int TIME_OUT = -1;
  static const int PROCESSING = 0;
  static const int NEW = 1;
  static const int FINDING = 2;
  static const int ACCEPTED = 3;
  static const int CANCELED_USER = 4;
  static const int CANCELED_PARTNER = 5;
  static const int CANCELED_ADMIN = 6;
  static const int IN_PROGRESS = 7;
  static const int FINISHED = 8;
  static const int RETURNING = 9;
  static const int INCIDENT = 10;
  static const int IN_PROGRESS_INCIDENT = 11;
  static const int WAITING_CONFIRM = 12;
  static const int INSTALL_FAILED = 19;
  static const int PENDING = 20;
  static const int FINISHED_RETURNED = 22;
}

class Collections {
  static const String FULL = 'full';
  static const String NONE = 'none';
  static const String APART = 'apart';
}

class Payment {
  static const String CASH = "cash";
  static const String E_CASH = "wallet";
  static const String ATM = "atm";
}
