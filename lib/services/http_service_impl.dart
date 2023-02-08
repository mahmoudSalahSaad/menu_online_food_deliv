import 'package:dio/dio.dart';

import 'http_service.dart';

const BASE_URL = 'https://menuegypt.com/api';
//const BASE_URL = 'http://10.0.2.2:8000/api';
const APP_TOKEN =
    '\$2y\$10\$HCLhSzCVc2/Ph3pC5MHiU.gxhRZeUuUQJDWwZWcqVcw4vQ0OIiZsy';

class HttpServiceImpl implements HttpService {
  Dio _dio;
  @override
  Future<Response> getRequest(String url, token) async {
    Response response;
    try {
      if (token != null) {
        _dio.options.headers['Authorization'] = "Bearer $token";
      }
      response = await _dio.get(url);
    } on DioError catch (e) {
      response = e.response;
    }

    return response;
  }

  @override
  Future<Response> postRequest(String url, postData, token) async {
    Response response;
    try {
      response = await _dio.post(url,
          data: postData,
          options: Options(headers: {
            "Authorization": "Bearer $token",
            "Language" : "ar"
          }));
    } on DioError catch (e) {
      response = e.response;
    }
    return response;
  }

  // initializeInterceptors() {
  //   _dio.interceptors.add(
  //     InterceptorsWrapper(
  //       onError: (error, handler) {
  //         handler.next(error);
  //       },
  //       onRequest: (requestOption, handler) {
  //         requestOption.headers = {
  //           'Accept': '/',
  //           'accept': 'application/json',
  //           'Content-Type': 'application/json',
  //           'Charset': 'utf-8',
  //           'Password': "123456",
  //           "Language": 'ar',
  //         };
  //         return handler.next(requestOption);
  //       },
  //       onResponse: (response, handler) {
  //         return handler.next(response);
  //       },
  //     ),
  //   );
  // }

  @override
  void init() {
    _dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      headers: {
        'appToken': APP_TOKEN,
        'Accept': '/',
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'Password': "123456",
        "Language": 'ar',
      },
    ));
  }
}
