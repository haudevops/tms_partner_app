import 'business_constant.dart';

// final method = PointStatusEnum.parse('ADVICE_FAILED');
// assert(method == PointStatusEnum.ADVICE_FAILED);

class PointStatusEnum {
  final int status;
  final int? type;
  final int actionType;

  const PointStatusEnum._(
      {required this.status, this.type, required this.actionType});

  static const ADVICE_FAILED = PointStatusEnum._(status: -4, actionType: -1);
  static const PICK_FAILED = PointStatusEnum._(status: -3, actionType: -1);
  static const INSTALL_FAILED = PointStatusEnum._(status: -2, actionType: -1);
  static const DELIVER_FAILED = PointStatusEnum._(status: -1, actionType: -1);
  static const NEW_PICK_POINT =
      PointStatusEnum._(status: 0, type: 1, actionType: 0);
  static const NEW_DELIVERY =
      PointStatusEnum._(status: 0, type: 2, actionType: 0);
  static const NEW_INSTALL =
      PointStatusEnum._(status: 0, type: 3, actionType: 0);
  static const NEW_RETURN =
      PointStatusEnum._(status: 0, type: 4, actionType: 0);
  static const NEW_RETURN_WAREHOUSE =
      PointStatusEnum._(status: 0, type: 5, actionType: 0);
  static const NEW_WARRANTY =
      PointStatusEnum._(status: 0, type: 6, actionType: 0);
  static const NEW_REPAIR =
      PointStatusEnum._(status: 0, type: 7, actionType: 0);
  static const NEW_CONSULTATION =
      PointStatusEnum._(status: 0, type: 8, actionType: 0);
  static const DELIVERED = PointStatusEnum._(status: 1, actionType: 1);
  static const INSTALLED = PointStatusEnum._(status: 2, actionType: 1);
  static const POINT_CANCEL = PointStatusEnum._(status: 3, actionType: -1);
  static const POINT_SKIPPED = PointStatusEnum._(status: 4, actionType: -1);
  static const POINT_INCIDENT_NEW = PointStatusEnum._(status: 5, actionType: 0);
  static const POINT_INCIDENT_ACCEPT =
      PointStatusEnum._(status: 6, actionType: 0);
  static const POINT_INCIDENT_DONE =
      PointStatusEnum._(status: 7, actionType: 1);
  static const POINT_ARRIVED_PICK =
      PointStatusEnum._(status: 8, type: 1, actionType: 0);
  static const POINT_ARRIVED_DELIVERY =
      PointStatusEnum._(status: 8, type: 2, actionType: 0);
  static const POINT_ARRIVED_INSTALL =
      PointStatusEnum._(status: 8, type: 3, actionType: 0);
  static const POINT_ARRIVED_RETURN =
      PointStatusEnum._(status: 8, type: 4, actionType: 0);
  static const POINT_ARRIVED_RETURN_WAREHOUSE =
      PointStatusEnum._(status: 8, type: 5, actionType: 0);
  static const POINT_ARRIVED_WARRANTY =
      PointStatusEnum._(status: 8, type: 6, actionType: 0);
  static const POINT_ARRIVED_REPAIR =
      PointStatusEnum._(status: 8, type: 7, actionType: 0);
  static const POINT_ARRIVED_INCIDENT =
      PointStatusEnum._(status: 8, type: 8, actionType: 0);
  static const RETURNED = PointStatusEnum._(status: 9, actionType: 1);
  static const RETURN_FAILED = PointStatusEnum._(status: 10, actionType: -1);
  static const PICK_SUCCESS = PointStatusEnum._(status: 11, actionType: 1);
  static const ACCEPT_QUOTATION = PointStatusEnum._(status: 12, actionType: 0);
  static const RETURN_WARRANTY_REPAIR =
      PointStatusEnum._(status: 13, actionType: 0);
  static const SCHEDULED = PointStatusEnum._(status: 14, actionType: 0);
  static const SEND_QUOTATION = PointStatusEnum._(status: 15, actionType: 0);
  static const DONE = PointStatusEnum._(status: 16, actionType: 1);
  static const FAILED = PointStatusEnum._(status: 17, actionType: -1);
  static const IN_PROGRESS = PointStatusEnum._(status: 19, actionType: 0);
  static const PICK_LATER =
      PointStatusEnum._(status: 20, type: 1, actionType: 0);
  static const DELIVERY_LATER =
      PointStatusEnum._(status: 20, type: 2, actionType: 0);
  static const RETURN_LATER =
      PointStatusEnum._(status: 20, type: 4, actionType: 0);
  static const PENDING = PointStatusEnum._(status: 21, actionType: -1);

  static const values = [
    ADVICE_FAILED,
    PICK_FAILED,
    INSTALL_FAILED,
    DELIVER_FAILED,
    NEW_PICK_POINT,
    NEW_DELIVERY,
    NEW_INSTALL,
    NEW_RETURN,
    NEW_RETURN_WAREHOUSE,
    NEW_WARRANTY,
    NEW_REPAIR,
    NEW_CONSULTATION,
    DELIVERED,
    INSTALLED,
    POINT_CANCEL,
    POINT_SKIPPED,
    POINT_INCIDENT_NEW,
    POINT_ARRIVED_RETURN,
    POINT_ARRIVED_RETURN_WAREHOUSE,
    POINT_ARRIVED_WARRANTY,
    POINT_ARRIVED_REPAIR,
    POINT_ARRIVED_INCIDENT,
    RETURNED,
    RETURN_FAILED,
    PICK_SUCCESS,
    ACCEPT_QUOTATION,
    RETURN_WARRANTY_REPAIR,
    SCHEDULED,
    SEND_QUOTATION,
    DONE,
    FAILED,
    IN_PROGRESS,
    PICK_LATER,
    DELIVERY_LATER,
    RETURN_LATER,
    PENDING
  ];

  static PointStatusEnum parse(int? status, int? type) {
    switch (status) {
      case -4:
        return ADVICE_FAILED;
      case -3:
        return PICK_FAILED;
      case -2:
        return INSTALL_FAILED;
      case -1:
        return DELIVER_FAILED;
      case 0:
      case 19:
        switch (type) {
          case PointType.DELIVERY_POINT:
          case PointType.DELIVERY_INSTALLATION_POINT:
            return NEW_DELIVERY;
          case PointType.INSTALLATION_POINT:
            return NEW_INSTALL;
          case PointType.RETURN_POINT:
            return NEW_RETURN;
          case PointType.RETURN_WAREHOUSE:
            return NEW_RETURN_WAREHOUSE;
          case PointType.WARRANTY:
            return NEW_WARRANTY;
          case PointType.REPAIR:
            return NEW_REPAIR;
          case PointType.CONSULTATION:
            return NEW_CONSULTATION;
          default:
            return NEW_PICK_POINT;
        }
      case 1:
        return DELIVERED;
      case 2:
        return INSTALLED;
      case 3:
        return POINT_CANCEL;
      case 4:
        return POINT_SKIPPED;
      case 5:
        return POINT_INCIDENT_NEW;
      case 6:
        return POINT_INCIDENT_ACCEPT;
      case 7:
        return POINT_INCIDENT_DONE;
      case 8:
        switch (type) {
          case PointType.PICK_POINT:
            return POINT_ARRIVED_PICK;
          case PointType.DELIVERY_POINT:
          case PointType.DELIVERY_INSTALLATION_POINT:
            return POINT_ARRIVED_DELIVERY;
          case PointType.INSTALLATION_POINT:
            return POINT_ARRIVED_INSTALL;
          case PointType.RETURN_POINT:
            return POINT_ARRIVED_RETURN;
          case PointType.RETURN_WAREHOUSE:
            return POINT_ARRIVED_RETURN_WAREHOUSE;
          case PointType.WARRANTY:
            return POINT_ARRIVED_WARRANTY;
          case PointType.REPAIR:
            return POINT_ARRIVED_REPAIR;
          default:
            return POINT_ARRIVED_INCIDENT;
        }
      case 9:
        return RETURNED;
      case 10:
        return RETURN_FAILED;
      case 11:
        return PICK_SUCCESS;
      case 12:
        return ACCEPT_QUOTATION;
      case 13:
        return RETURN_WARRANTY_REPAIR;
      case 14:
        return SCHEDULED;
      case 15:
        return SEND_QUOTATION;
      case 16:
        return DONE;
      case 17:
        return FAILED;
      case 20:
        switch (type) {
          case PointType.PICK_POINT:
            return PICK_LATER;
          case PointType.DELIVERY_POINT:
          case PointType.DELIVERY_INSTALLATION_POINT:
            return DELIVERY_LATER;
          case PointType.RETURN_POINT:
            return RETURN_LATER;
          default:
            return PICK_LATER;
        }
      case 21:
        return PENDING;
      default:
        return NEW_PICK_POINT;
    }
  }
}
