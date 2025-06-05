import 'package:flutter/material.dart';
import 'package:iplay/core/functions/theme_colors.dart';
import 'package:iplay/ui/executar_quiz/executar_quiz_presenter.dart';
import 'package:iplay/ui/inicio/inicio_controller.dart';
import 'package:iplay/ui/inicio/widgets/card_recomendacao.dart';
import 'package:iplay/ui/widgets/botao_padrao.dart';

class InicioScreen extends StatelessWidget {
  final InicioController controller;
  const InicioScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 24),
          BotaoPadrao(
            onPressed: () async {
              final response = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ExecutarQuizPresenter()));
              if (response != Null && response == true) {
                controller.buscarRecomendacoes();
              }
            },
            color: ThemeColors.secondary,
            label: 'Iniciar quiz',
            buttonIsLoading: false,
          ),
          const SizedBox(height: 32),
          const Text(
            'Recomendações',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          if (controller.carregandoRecomendacoes) const Center(child: Column(
            children: [
              SizedBox(height: 16),
              Text('Carregando jogos...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              CircularProgressIndicator(),
            ],
          )),
          if (controller.recomendacoes.isEmpty && controller.carregandoRecomendacoes == false)
            Column(
              children: [
                const Text(
                  'Nenhuma recomendação encontrada\nClique em "Iniciar quiz" para gerar recomendações',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                const Icon(Icons.sentiment_dissatisfied, size: 40),
              ],
            ),
          if (controller.recomendacoes.isNotEmpty && controller.carregandoRecomendacoes == false)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.recomendacoes.length,
              itemBuilder: (context, index) {
                final recomendacao = controller.recomendacoes[index];
                return CardRecomendacao(recomendacao: recomendacao);
              },
            ),
        ],
      ),
    );
  }
}
