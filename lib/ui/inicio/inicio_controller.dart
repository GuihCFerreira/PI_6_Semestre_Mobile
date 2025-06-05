import 'package:flutter/material.dart';
import 'package:iplay/core/dtos/recomendacao.dart';
import 'package:iplay/core/functions/identificar_erro.dart';
import 'package:iplay/core/repositories/usuarios_repository.dart';
import 'package:iplay/core/services/snackbar_service.dart';
import 'dart:developer' as developer;

class InicioController extends ChangeNotifier {
  final SnackBarService snackBarService;
  final UsuariosRepository usuariosRepository;

  List<RecomendacaoDto> recomendacoes = [];
  bool carregandoRecomendacoes = false;

  InicioController({
    required this.snackBarService,
    required this.usuariosRepository,
  });

  Future<void> buscarRecomendacoes() async {
    try {
      setCarregandoRecomendacoes(true);
      recomendacoes = await usuariosRepository.recomendacoesJogos();
    } catch (e) {
      developer.log('Erro ao buscar recomendações: $e', error: e);
      snackBarService.showMessage(message: identificarErro(error: e, message: 'Erro ao buscar recomendações.'), color: Colors.red);
    } finally {
      setCarregandoRecomendacoes(false);
    }
  }

  void setCarregandoRecomendacoes(bool value) {
    carregandoRecomendacoes = value;
    if (hasListeners) {
      notifyListeners();
    }
  }
}
