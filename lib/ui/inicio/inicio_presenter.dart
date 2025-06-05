import 'package:flutter/material.dart';
import 'package:iplay/core/injection/injecao_dependencias.dart';
import 'package:iplay/core/repositories/usuarios_repository.dart';
import 'package:iplay/core/services/snackbar_service.dart';
import 'package:iplay/ui/inicio/inicio_controller.dart';
import 'package:iplay/ui/inicio/inicio_screen.dart';
import 'package:iplay/ui/widgets/background.dart';

class InicioPresenter extends StatefulWidget {
  const InicioPresenter({super.key});

  @override
  State<InicioPresenter> createState() => _InicioPresenterState();
}

class _InicioPresenterState extends State<InicioPresenter> {
  late InicioController controller;

  @override
  void initState() {
    super.initState();
    controller = InicioController(
      snackBarService: getIt<SnackBarService>(),
      usuariosRepository: getIt<UsuariosRepository>(),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.buscarRecomendacoes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
      ),
      body: Background(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return InicioScreen(controller: controller);
          },
        ),
      ),
    );
  }
}
