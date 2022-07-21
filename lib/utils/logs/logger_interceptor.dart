import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tms_partner_app/config/define_service_api.dart';
import 'package:tms_partner_app/utils/constants.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    if (environment != Constants.PROD_ENVIRONMENT) {
      logPrint('\n');
      logPrint(
          '***======================== Request ========================***');
      logPrint('--> ${options.method} ${options.uri}');
      options.headers.forEach((key, v) => printKV('$key', v));

      if (options.data != null) {
        printAll(options.data);
      }
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if (environment != Constants.PROD_ENVIRONMENT) {
      logPrint('');
      logPrint('--> END ${err.requestOptions.method}');
      if (err.response != null) {
        logPrint(
            '<-- ${err.response?.statusCode?.toString()} ${err.requestOptions.uri}');
        printAll(err.response?.toString());
      }
      logPrint('$err');
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    if (environment != Constants.PROD_ENVIRONMENT) {
      logPrint('');
      logPrint('--> END ${response.requestOptions.method}');
      logPrint('<-- ${response.statusCode} ${response.requestOptions.uri}');
      printAll(response.data ?? '');
      logPrint(
          '***======================== End Request ========================***');
    }
  }

  void logPrint(String msg) {
    if (kDebugMode) {
      print('${DateTime.now()} Api: $msg');
    }
  }

  void printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }

  void printKV(String key, Object v) {
    logPrint('$key: $v');
  }
}
