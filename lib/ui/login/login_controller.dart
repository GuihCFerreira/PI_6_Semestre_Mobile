import 'package:flutter/material.dart';
import 'package:iplay/core/functions/identificar_erro.dart';
import 'package:iplay/core/providers/user_provider.dart';
import 'package:iplay/core/repositories/usuarios_repository.dart';
import 'package:iplay/core/services/snackbar_service.dart';
import 'dart:developer' as developer;

class LoginController extends ChangeNotifier {
  final UsuariosRepository usuariosRepository;
  final SnackBarService snackBarService;
  final UserProvider userProvider;

  LoginController({
    required this.usuariosRepository,
    required this.snackBarService,
    required this.userProvider,
  });

  Future<bool> login() async {
    if (formKey.currentState!.validate()) {
      try {
        setBotaoLoading(true);
        final response = await usuariosRepository.login(
          email: emailController.text,
          senha: senhaController.text,
        );
        userProvider.setUser(response);
        snackBarService.showMessage(message: "Login realizado com sucesso!", color: Colors.green);
        return true;
      } catch (e) {
        developer.log('Erro ao realizar login: $e', name: 'LoginController');
        snackBarService.showMessage(message: identificarErro(error: e, message: "Erro ao realizar login"), color: Colors.red);
      } finally {
        setBotaoLoading(false);
      }
    }
    return false;
  }

  bool botaoIsLoading = false;
  bool senhaIsVisivel = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void toggleSenhaVisivel() {
    senhaIsVisivel = !senhaIsVisivel;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setBotaoLoading(bool loading) {
    botaoIsLoading = loading;
    if (hasListeners) {
      notifyListeners();
    }
  }
}
