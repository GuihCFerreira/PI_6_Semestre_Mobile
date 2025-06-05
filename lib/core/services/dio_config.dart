import 'package:dio/dio.dart';

class DioConfig {
  DioConfig._privateConstructor();

  static final DioConfig _instance = DioConfig._privateConstructor();
  static Dio get dio => _instance._dio;

  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://iplay-dte2ffd6aghdd2cx.brazilsouth-01.azurewebsites.net/",
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    contentType: 'application/json; charset=utf-8',
  ));

  factory DioConfig() {
    return _instance;
  }
}
