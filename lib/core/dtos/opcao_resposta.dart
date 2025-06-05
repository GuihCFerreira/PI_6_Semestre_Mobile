class OpcaoRespostaDto {
  final String resposta;
  final String valor;

  OpcaoRespostaDto({
    required this.resposta,
    required this.valor,
  });

  factory OpcaoRespostaDto.fromJson(Map<String, dynamic> json) {
    return OpcaoRespostaDto(
      resposta: json['answer'] as String,
      valor: json['value'] as String,
    );
  }
}
