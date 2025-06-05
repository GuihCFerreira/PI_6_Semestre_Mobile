import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:iplay/core/functions/erro_interno.dart';

String identificarErro({required dynamic error, required String message}) {
  String messageError = message;

  // Captura a stack trace
  // final stackTrace = StackTrace.current;
  // print('identificarErro foi chamado por:\n$stackTrace');

  // // ou, se quiser apenas a linha exata do chamador:
  // final caller = StackTrace.current.toString().split('\n')[1];
  // print('Chamador direto: $caller');

  if (error is TimeoutException) {
    return 'Tempo esgotado. Verifique sua conexão com a internet.';
  }

  if (error is TypeError) {
    return 'Erro de tipo.';
  }

  if (error is SocketException) {
    return 'Sem conexão com a internet. Verifique sua rede.';
  }

  if (error is ErroInterno) {
    return error.message;
  }

  if (error is DioException && error.response?.data != null && error.response?.data['message'] != null) {
    return error.response?.data['message'];
  }

  return messageError;
}
