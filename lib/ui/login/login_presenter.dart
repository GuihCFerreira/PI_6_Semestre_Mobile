import 'package:flutter/material.dart';
import 'package:iplay/core/injection/injecao_dependencias.dart';
import 'package:iplay/core/providers/user_provider.dart';
import 'package:iplay/core/repositories/usuarios_repository.dart';
import 'package:iplay/core/services/snackbar_service.dart';
import 'package:iplay/ui/login/login_controller.dart';
import 'package:iplay/ui/login/login_screen.dart';
import 'package:iplay/ui/widgets/background.dart';

class LoginPresenter extends StatefulWidget {
  const LoginPresenter({super.key});

  @override
  State<LoginPresenter> createState() => _LoginPresenterState();
}

class _LoginPresenterState extends State<LoginPresenter> {
  late LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = LoginController(
      usuariosRepository: getIt<UsuariosRepository>(),
      snackBarService: getIt<SnackBarService>(),
      userProvider: getIt<UserProvider>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Background(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return LoginScreen(controller: controller);
          },
        ),
      ),
    );
  }
}
