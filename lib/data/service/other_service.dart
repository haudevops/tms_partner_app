

import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/api/patch_api.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/utils/constants.dart';

import '../../base/base_response.dart';
import '../../base/base_service.dart';

class OtherService {
  OtherService._internal();

  static final OtherService instance = OtherService._internal();

  final _baseService = BaseService();

  Future<NewsResponse> getNews(String page, String limit, String newsCatIds,
      String sortBy, String sortWay) async {
    final BaseResponse<Map<String, dynamic>> response = await _baseService
        .get<Map<String, dynamic>>(Apis.patchGetNews, params: {
      'page': page,
      'limit': limit,
      'newsCatIds': newsCatIds,
      'sortBy': sortBy,
      'sortWay': sortWay
    });

    if (response.errorCode == Constants.ERROR_CODE) {
      return Future.error(response.message);
    }

    return NewsResponse.fromJson(response.data!);
  }

  Future<ActivitiesModel> getNotification(int page, int limit) async {
    final BaseResponse response = await _baseService
        .get(Apis.patchGetNews, params: {'page': page, 'limit': limit});

    if (response.errorCode == Constants.ERROR_CODE) {
      return ActivitiesModel(
          errorCode: response.errorCode, message: response.message);
    }

    return ActivitiesModel.fromJson(response.data!);
  }

  Future<PushLocationResponse> pushLocation(
      {String? vehicleTypeId,
      String? address,
      double? lng,
      double? lat,
      double? bearing}) async {
    final BaseResponse response =
        await _baseService.post(Apis.pushLocation, params: {
      'vehicleTypeId': vehicleTypeId ?? '',
      'address': address ?? '',
      'lat': lng ?? Constants.DEFAULT_POINT_LAT,
      'lng': lng ?? Constants.DEFAULT_POINT_LNG,
      'bearing': bearing ?? 0,
    });

    if (response.errorCode == Constants.ERROR_CODE) {
      return PushLocationResponse(
          errorCode: response.errorCode, message: response.message);
    }

    return PushLocationResponse.fromJson(response.data!);
  }
}
