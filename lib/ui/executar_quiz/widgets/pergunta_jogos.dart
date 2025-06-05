import 'package:flutter/material.dart';
import 'package:iplay/core/functions/theme_colors.dart';
import 'package:iplay/ui/executar_quiz/executar_quiz_controller.dart';
import 'package:iplay/ui/widgets/input_padrao.dart';

class PerguntaJogos extends StatelessWidget {
  final ExecutarQuizController controller;
  const PerguntaJogos({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final jogos = controller.jogos;

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
          const SizedBox(height: 8),
          InputPadrao(
            controller: controller.nomeJogoController,
            label: 'Nome do jogo',
            hintText: 'Digite o nome do jogo',
            prefixIcon: Icons.gamepad,
            suffixIcon: IconButton(
              onPressed: () {
                controller.buscarMaisJogos = true;
                controller.setJogos([]);
                controller.buscarJogos();
              },
              icon: const Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 16),
          if (jogos.isEmpty && !controller.carregandoJogos)
            Column(
              children: [
                const Text(
                  'Nenhum jogo encontrado\nClique no ícone de pesquisa para buscar jogos',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                const Icon(Icons.sentiment_dissatisfied, size: 40),
              ],
            ),
          if (jogos.isNotEmpty)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  final jogo = jogos[index];

                  // Correção: adicionar uma condição para evitar múltiplas chamadas
                  if (index == jogos.length - 1 && !controller.carregandoJogos) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!controller.carregandoJogos) {
                        controller.buscarJogos();
                      }
                    });
                  }

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
                          controller.toggleSelecionarJogo(jogo);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Image.network(jogo.urlImagem),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  jogo.resposta,
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
                                value: controller.jogoSelecionado(jogo),
                                activeColor: ThemeColors.primary,
                                onChanged: (bool? value) {
                                  controller.toggleSelecionarJogo(jogo);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: jogos.length,
              ),
            ),
          const SizedBox(height: 16),
          if (controller.carregandoJogos)
            const Center(
              child: CircularProgressIndicator(
                color: ThemeColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}
