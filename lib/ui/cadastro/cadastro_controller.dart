import 'package:flutter/material.dart';
import 'package:iplay/core/functions/identificar_erro.dart';
import 'package:iplay/core/repositories/usuarios_repository.dart';
import 'package:iplay/core/services/snackbar_service.dart';
import 'dart:developer' as developer;

class CadastroController extends ChangeNotifier {
  final UsuariosRepository usuariosRepository;
  final SnackBarService snackBarService;

  CadastroController({
    required this.usuariosRepository,
    required this.snackBarService,
  });

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool botaoIsLoading = false;
  bool senhaIsVisivel = false;

  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();

  Future<bool> cadastrar() async {
    if (formKey.currentState!.validate()) {
      try {
        setBotaoLoading(true);
        final usuario = {
          'name': nomeController.text,
          'email': emailController.text,
          'password': senhaController.text,
        };

        await usuariosRepository.cadastrarUsuario(usuario);
        snackBarService.showMessage(message: "Usuário cadastrado com sucesso!", color: Colors.green);
        return true;
      } catch (e) {
        developer.log('Erro ao cadastrar usuário: $e', name: 'CadastroController');
        snackBarService.showMessage(message: identificarErro(error: e, message: "Erro ao cadastrar usuário"), color: Colors.red);
      } finally {
        setBotaoLoading(false);
      }
    }
    return false;
  }

  void toggleSenhaVisivel() {
    setSenhaVisivel(!senhaIsVisivel);
  }

  void setBotaoLoading(bool loading) {
    botaoIsLoading = loading;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setSenhaVisivel(bool visivel) {
    senhaIsVisivel = visivel;
    if (hasListeners) {
      notifyListeners();
    }
  }
}
