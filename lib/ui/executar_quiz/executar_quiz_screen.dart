import 'package:flutter/material.dart';
import 'package:iplay/core/enums/tipo_perguntas.dart';
import 'package:iplay/ui/executar_quiz/executar_quiz_controller.dart';
import 'package:iplay/ui/executar_quiz/widgets/pergunta_jogos.dart';
import 'package:iplay/ui/executar_quiz/widgets/pergunta_padrao.dart';

class ExecutarQuizScreen extends StatelessWidget {
  final ExecutarQuizController controller;
  const ExecutarQuizScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final perguntaAtual = controller.perguntaAtual;

    if (perguntaAtual != null && perguntaAtual.perguntaDto.tipoPergunta == TipoPerguntasEnum.variosCheckBox) {
      return PerguntaPadrao(controller: controller);
    } else if (perguntaAtual != null && perguntaAtual.perguntaDto.tipoPergunta == TipoPerguntasEnum.inputCheckBox) {
      return PerguntaJogos(controller: controller);
    }
    return CircularProgressIndicator();
  }
}
