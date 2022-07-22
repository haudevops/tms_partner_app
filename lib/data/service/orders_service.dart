import 'dart:developer';

import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/api/patch_api.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/utils/constants.dart';

import '../../base/base_response.dart';
import '../../base/base_service.dart';

class OrdersService {
  OrdersService._internal();

  static final OrdersService instance = OrdersService._internal();

  final _baseService = BaseService();

  Future<StatisticalModel> getStatistical() async {
    final BaseResponse<Map<String, dynamic>> response =
        await _baseService.get<Map<String, dynamic>>(Apis.patchGetStatistical);

    if (response.errorCode == Constants.ERROR_CODE) {
      return StatisticalModel(
          errorCode: response.errorCode, message: response.message);
    }

    return StatisticalModel.fromJson(response.data!);
  }

  Future<OrdersResponse> getOrders(
      {String? from,
      String? to,
      String? page,
      String? limit,
      String? staffIds,
      String? code,
      String? externalCode,
      String? store,
      String? serviceType,
      String? status,
      String? submitted,
      bool? optimize}) async {
    final BaseResponse response =
        await _baseService.get(Apis.patchGetOrders, params: {
      'to': to,
      'page': page,
      'limit': limit,
      'staffIds': staffIds,
      'code': code,
      'externalCode': externalCode,
      'store': store,
      'serviceType': serviceType,
      'status': status,
      'submitted': submitted,
      'optimize': optimize,
    });

    if (response.errorCode == Constants.ERROR_CODE) {
      return OrdersResponse(
          errorCode: response.errorCode, message: response.message);
    }

    return OrdersResponse.fromJson(response.data!);
  }

  Future<OrdersResponse> getOrderGroup(
      {required String orderIds, required int limit}) async {
    final BaseResponse response = await _baseService.post(Apis.patchGetOrders,
        params: {'orderId': orderIds, 'limit': limit});

    if (response.errorCode == Constants.ERROR_CODE) {
      return OrdersResponse(
          errorCode: response.errorCode, message: response.message);
    }

    return OrdersResponse.fromJson(response.data!);
  }

  Future<OrderModel> getOrder({required String? orderId}) async {
    final BaseResponse response =
        await _baseService.get('${Apis.patchGetOrder}/$orderId');

    if (response.errorCode == Constants.ERROR_CODE) {
      return OrderModel(
          errorCode: response.errorCode,
          message: response.message,
          isChildOrder: false,
          expandGroup: false,
          countSO: 0);
    }

    return OrderModel.fromJson(response.data!);
  }

  Future<OrderModel> doArrivedInOrderGroup(
      {required String? orderID, required String? pointId}) async {
    String uriArrivedInOrderGroup =
        '${Apis.patchArrivedInOrderGroup}/$orderID/point/$pointId/arrived';
    final BaseResponse response =
        await _baseService.post(uriArrivedInOrderGroup);

    if (response.errorCode == Constants.ERROR_CODE) {
      return OrderModel(
          errorCode: response.errorCode,
          message: response.message,
          isChildOrder: false,
          expandGroup: false,
          countSO: 0);
    }

    return OrderModel.fromJson({'message': response.message});
  }

  Future<OrderModel> doPickupSuccess(
      {required String? orderID, required String? pointId}) async {
    String uriArrivedInOrderGroup =
        '${Apis.patchPickupOrder}/$orderID/point/$pointId/pickup';
    final BaseResponse response =
    await _baseService.post(uriArrivedInOrderGroup);

    if (response.errorCode == Constants.ERROR_CODE) {
      return OrderModel(
          errorCode: response.errorCode,
          message: response.message,
          isChildOrder: false,
          expandGroup: false,
          countSO: 0);
    }

    return OrderModel.fromJson({'message': response.message});
  }
}
