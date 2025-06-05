import 'package:iplay/core/enums/tipo_perguntas.dart';

class PerguntaDto {
  final String questao;
  final String tag;
  final int minimoRespostas;
  final TipoPerguntasEnum tipoPergunta;

  PerguntaDto({
    required this.questao,
    required this.tag,
    required this.minimoRespostas,
    required this.tipoPergunta,
  });

  //fromJson
  factory PerguntaDto.fromJson(Map<String, dynamic> json) {
    return PerguntaDto(
      questao: json['question'] as String,
      tag: json['tag'] as String,
      minimoRespostas: json['min_length'] as int,
      tipoPergunta: TipoPerguntasEnum.fromString(json['type'] as String),
    );
  }
}
