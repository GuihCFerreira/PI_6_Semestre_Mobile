import 'package:flutter/material.dart';
import 'package:iplay/core/functions/theme_colors.dart';
import 'package:iplay/ui/executar_quiz/executar_quiz_controller.dart';

class PerguntaPadrao extends StatelessWidget {
  final ExecutarQuizController controller;
  const PerguntaPadrao({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final opcoes = controller.perguntaAtual?.opcoesResposta ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            '${controller.perguntaAtual?.perguntaDto.questao}',
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final opcao = opcoes[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      radius: 8,
                      onTap: () {
                        controller.toogleSelecionarOpcao(opcao);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                opcao.opcaoRespostaDto.resposta,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Checkbox(
                              value: opcao.selecionada,
                              activeColor: ThemeColors.primary,
                              onChanged: (bool? value) {
                                controller.toogleSelecionarOpcao(opcao);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: opcoes.length,
            ),
          )
        ],
      ),
    );
  }
}
