import 'package:iplay/core/dtos/pergunta_dto.dart';
import 'package:iplay/core/model/opcao_resposta_model.dart';

class PerguntaModel {
  final PerguntaDto perguntaDto;
  final List<OpcaoRespostaModel> opcoesResposta;

  PerguntaModel({
    required this.perguntaDto,
    required this.opcoesResposta,
  });

  List<String> get opcoesSelecionadas {
    return opcoesResposta.where((opcao) => opcao.selecionada).map((opcao) => opcao.opcaoRespostaDto.valor).toList();
  }

  //fromjson
  factory PerguntaModel.fromJson(Map<String, dynamic> json) {
    PerguntaDto perguntaDto = PerguntaDto.fromJson(json);
    List<OpcaoRespostaModel> opcoesResposta = (json['options'] as List)
        .map(
          (opcaoJson) => OpcaoRespostaModel.fromJson(opcaoJson as Map<String, dynamic>),
        )
        .toList();
    return PerguntaModel(
      perguntaDto: perguntaDto,
      opcoesResposta: opcoesResposta,
    );
  }

  int get quantidadeOpcoesSelecionadas {
    return opcoesResposta.where((opcao) => opcao.selecionada).length;
  }

  List<String> get respostaOpcoesSelecionadas {
    return opcoesResposta.where((opcao) => opcao.selecionada).map((opcao) => opcao.opcaoRespostaDto.valor.toString()).toList();
  }
}
