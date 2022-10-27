import 'package:dio/dio.dart';

abstract class HttpService {
  void init();

  Future<Response> getRequest(String url, String accessToken);
  Future<Response> postRequest(
      String url, Map<String, dynamic> postData, String token);
}
