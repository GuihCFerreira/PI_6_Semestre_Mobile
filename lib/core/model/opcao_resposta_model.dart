import 'package:iplay/core/dtos/opcao_resposta.dart';

class OpcaoRespostaModel {
  final OpcaoRespostaDto opcaoRespostaDto;
  bool selecionada;

  OpcaoRespostaModel({
    required this.opcaoRespostaDto,
    required this.selecionada,
  });

  // fromJson
  factory OpcaoRespostaModel.fromJson(Map<String, dynamic> json) {
    return OpcaoRespostaModel(opcaoRespostaDto: OpcaoRespostaDto.fromJson(json), selecionada: false);
  }

  void tooggleSelecionada() {
    selecionada = !selecionada;
  }
}
