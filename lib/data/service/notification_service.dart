
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/api/patch_api.dart';
import 'package:tms_partner_app/utils/constants.dart';

import '../../base/base_response.dart';
import '../../base/base_service.dart';
import '../model/models.dart';

class NotificationService {
  NotificationService._internal();

  static final NotificationService instance = NotificationService._internal();

  final _baseService = BaseService();

  Future<ActivitiesModel> getNotification(
      [int page = 1, int limit = Constants.LIMIT]) async {
    final BaseResponse response = await _baseService
        .get(Apis.patchactivities, params: {'page': page, 'limit': limit});

    if (response.errorCode == Constants.ERROR_CODE) {
      return ActivitiesModel(
          errorCode: response.errorCode, message: response.message);
    }

    return ActivitiesModel.fromJson(response.data!);
  }
}
