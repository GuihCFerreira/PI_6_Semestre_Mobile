import 'package:flutter/material.dart';
import 'package:iplay/core/enums/state_enum.dart';
import 'package:iplay/core/injection/injecao_dependencias.dart';
import 'package:iplay/core/repositories/perguntas_repository.dart';
import 'package:iplay/core/services/snackbar_service.dart';
import 'package:iplay/ui/executar_quiz/executar_quiz_controller.dart';
import 'package:iplay/ui/executar_quiz/executar_quiz_screen.dart';
import 'package:iplay/ui/widgets/background.dart';
import 'package:iplay/ui/widgets/botao_padrao.dart';

class ExecutarQuizPresenter extends StatefulWidget {
  const ExecutarQuizPresenter({super.key});

  @override
  State<ExecutarQuizPresenter> createState() => _ExecutarQuizPresenterState();
}

class _ExecutarQuizPresenterState extends State<ExecutarQuizPresenter> {
  late ExecutarQuizController controller;

  @override
  void initState() {
    super.initState();
    controller = ExecutarQuizController(
      perguntasRepository: getIt<PerguntasRepository>(),
      snackBarService: getIt<SnackBarService>(),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.buscarPerguntas();
      controller.buscarJogos();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(controller.scaffoldTitulo),
            ),
            
            body: child(),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: BotaoPadrao(
                      onPressed: () {
                        controller.voltarPergunta();
                      },
                      label: 'Voltar',
                      buttonIsLoading: controller.criandoQuiz,
                      color: controller.indexPerguntaAtual == 1 ? Colors.grey[350] : Colors.grey[500],
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: BotaoPadrao(
                      onPressed: () async {
                        final response = await controller.toggleAvancarPergunta();
                        if (response) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pop(context, response);
                          });
                        }
                      },
                      label: controller.indexPerguntaAtual == controller.perguntas.length ? 'Finalizar' : 'Avançar',
                      buttonIsLoading: controller.criandoQuiz,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget child() {
    if (controller.state == StateEnum.carregando) {
      return const Center(child: CircularProgressIndicator());
    } else if (controller.state == StateEnum.erro) {
      return ErrorWidget(
        'Erro ao carregar perguntas. Tente novamente.',
      );
    } else if (controller.perguntas.isEmpty) {
      return const Center(child: Text('Nenhuma pergunta encontrada.'));
    }

    return ExecutarQuizScreen(controller: controller);
  }
}
