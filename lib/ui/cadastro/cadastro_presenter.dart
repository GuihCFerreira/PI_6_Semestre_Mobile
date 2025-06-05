import 'package:flutter/material.dart';
import 'package:iplay/core/injection/injecao_dependencias.dart';
import 'package:iplay/core/repositories/usuarios_repository.dart';
import 'package:iplay/core/services/snackbar_service.dart';
import 'package:iplay/ui/cadastro/cadastro_controller.dart';
import 'package:iplay/ui/cadastro/cadastro_screen.dart';
import 'package:iplay/ui/widgets/background.dart';

class CadastroPresenter extends StatefulWidget {
  const CadastroPresenter({super.key});

  @override
  State<CadastroPresenter> createState() => _CadastroPresenterState();
}

class _CadastroPresenterState extends State<CadastroPresenter> {
  late final CadastroController controller;

  @override
  void initState() {
    super.initState();
    controller = CadastroController(
      usuariosRepository: getIt<UsuariosRepository>(),
      snackBarService: getIt<SnackBarService>(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Background(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return CadastroScreen(controller: controller);
          },
        ),
      ),
    );
  }
}
