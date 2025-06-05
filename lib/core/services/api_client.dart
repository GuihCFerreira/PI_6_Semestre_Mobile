import 'package:dio/dio.dart';
import 'package:iplay/core/functions/limitador_requisicoes.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({required Dio dio}) : _dio = dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    LimitadorRequisicoes.instance.verificar(acao: path);
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Options? options,
  }) {
    LimitadorRequisicoes.instance.verificar(acao: path);
    return _dio.post<T>(
      path,
      data: data,
      options: options,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Options? options,
  }) {
    LimitadorRequisicoes.instance.verificar(acao: path);
    return _dio.put<T>(
      path,
      data: data,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Options? options,
  }) {
    LimitadorRequisicoes.instance.verificar(acao: path);
    return _dio.delete<T>(
      path,
      data: data,
      options: options,
    );
  }
}
