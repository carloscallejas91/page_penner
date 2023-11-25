import "package:dio/dio.dart";
import "package:page_penner/core/configs/config.dart";

class RestHttp {
  Dio make({String? baseUrl}) {
    final Dio dio = Dio();

    if (dio.options.responseType == ResponseType.json){
      dio.options.responseType = ResponseType.plain;
    }


    dio.interceptors.add(LogInterceptor(
        responseBody: false,
        requestBody: true,
        requestHeader: true,
        error: true));

    dio.options.baseUrl = baseUrl ?? Config.urlBaseBookApi;

    return dio;
  }
}
