import 'package:iplay/core/functions/erro_interno.dart';
import 'dart:developer' as developer;

class LimitadorRequisicoes {
  LimitadorRequisicoes._();
  static final instance = LimitadorRequisicoes._();

  int quantidadeMaximaRequisicoesMinuto = 300;
  int quantidadeRequisicoes = 0;
  DateTime ultimoAcesso = DateTime.now();

  void verificar({required String acao}) {
    final agora = DateTime.now();
    final diferenca = agora.difference(ultimoAcesso);

    if (diferenca.inMinutes >= 1) {
      quantidadeRequisicoes = 0;
      ultimoAcesso = agora;
    }
    developer.log("$quantidadeRequisicoes  -  $acao");

    if (quantidadeRequisicoes < quantidadeMaximaRequisicoesMinuto) {
      quantidadeRequisicoes++;
      return;
    }

    throw ErroInterno(message: "Limite de requisições atingido");
  }
}
