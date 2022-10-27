import 'package:dio/dio.dart';

import 'http_service.dart';

const BASE_URL = 'https://menuegypt.com/api';
//const BASE_URL = 'http://10.0.2.2:8000/api';
const APP_TOKEN =
    '\$2y\$10\$HCLhSzCVc2/Ph3pC5MHiU.gxhRZeUuUQJDWwZWcqVcw4vQ0OIiZsy';

class HttpServiceImpl implements HttpService {
  Dio _dio;
  @override
  Future<Response> getRequest(String url, String accessToken) async {
    Response response;
    try {
      // if (accessToken != null) {
      //   _dio.options.headers['Authorization'] =
      //       "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiMzcyMjU0NTc0YTk0NDAyNjhlYTNmZDQ5NjI2OTJlNDhhMTkxMzNjNGRiYWY4MDBjOGMwYTg3ZTdiZmNiNGNhM2Q1ZmE4MWZiOTY3ZWMwMjkiLCJpYXQiOjE2MTk0NTIyMzEuMzA2MzUwOTQ2NDI2MzkxNjAxNTYyNSwibmJmIjoxNjE5NDUyMjMxLjMwNjM1NjkwNjg5MDg2OTE0MDYyNSwiZXhwIjoxNjUwOTg4MjMxLjI5ODQxODA0NTA0Mzk0NTMxMjUsInN1YiI6IjQiLCJzY29wZXMiOltdfQ.fnqs4WNU-uUcperJoSrs6vRcPqP4Rv5sCsp1LU-doEVgV0mV7ry7TUrSMzH8f1BWAsm57fxqJzosRoQ_g_d1fU7eV-q-xfsXx0X6CYp9KxcPodfPcdqSjTBF0zeWVwNsmDrb0mrF1OLB0ICWrZL65lVppXa_Pbg4T56vWjiF0rkPYJVQ67YAsmIIyof0Xqf4W7iDXcuwjFzbNzZV2BytpRZ-XO1wbSp8FFoPeXD4IFSI_zLNXnO-P92vApXvAGxHyJNOxpb2aP0zY8bw1oe7vbVzJGUsnY97KRRKM22QgqHZuLCxSHOStXchsu4rIi2pgOCPutlmghx3uJHGcb8KmOvevRvpnx2BpkwSbU4WXoyZwmZL8Tdn0VLYkllOyzuU5bEM6wdtbum_axQjUoIr5a0VVQoepJHpCwWIYmeHPdHxnuDyB-IYrGIr-uAn0fHzfInBVsJtrvKoZfFn8My5kAgAjHsrpo23J_bg91m-2yfk82FgKV9UBLUt1OpyGugopCP1KZz97Q5pBsMXuwAoGjcnPFciaeLAA_7lygaUcRRHO6FzoKVa8WN-Kk_BQRZDXWfGqxRHogD3j6EQxl5Zy-ZWvBcIYl52nlcBN2m88-ESADcNuyyDpiLCtlxwxawMn3zfr3ACqMa8UadsymJlo0a-H-GcIDAPVY-BsM5cFyk";
      // }
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
