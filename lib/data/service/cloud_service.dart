
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/config/define_service_api.dart';
import 'package:tms_partner_app/data/api/patch_api.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/utils/account_utils.dart';
import 'package:tms_partner_app/utils/constants.dart';
import 'package:tms_partner_app/utils/logs/logger_interceptor.dart';

import '../../base/base_response.dart';
import '../../base/base_service.dart';

class CloudService {
  factory CloudService() {
    return _instance;
  }

  CloudService._internal() {
    final options = BaseOptions(
      baseUrl: cloudUrl,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      contentType: 'multipart/form-data',
      responseType: ResponseType.json,
    );
    dio = Dio(options);
    dio.interceptors.add(LoggerInterceptor());
  }

  static final CloudService _instance = CloudService._internal();
  late Dio dio;

  Future<CloudResponse> upload(List<XFile> xFile) async {
    late BaseResponse baseResponse;

    FormData data = FormData.fromMap({
      "files": xFile
          .map((e) => MultipartFile.fromFileSync(e.path,
              filename: _getNameFile(e.path),
              contentType: new MediaType("image", "png")))
          .toList(),
    });

    final _headerOptions = Options(headers: {
      'code': cloudKey,
      'Authorization': 'Bearer ${AccountUtil.instance.getToken()}',
    });

    try {
      final response =
          await dio.post(Apis.patchUpload, data: data, options: _headerOptions);
      baseResponse = BaseService().handleResponse(response);
    } on DioError catch (e) {
      baseResponse = BaseResponse(
          errorCode: createErrorEntity(e).code,
          message: createErrorEntity(e).message);
    }

    if (baseResponse.errorCode == Constants.ERROR_CODE) {
      return CloudResponse(
          errorCode: baseResponse.errorCode, message: baseResponse.message);
    }

    return CloudResponse.fromJson(baseResponse.data!);
  }

  String _getNameFile(String file) {
    return 'IMG_${file.split('picker').last}';
  }
}
