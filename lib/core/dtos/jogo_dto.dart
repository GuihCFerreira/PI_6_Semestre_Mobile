class JogoDto {
  final String resposta;
  final int valor;
  final String urlImagem;

  JogoDto({
    required this.resposta,
    required this.valor,
    required this.urlImagem,
  });

//fromjson
  factory JogoDto.fromJson(Map<String, dynamic> json) {
    return JogoDto(
      resposta: json['answer'] as String,
      valor: json['value'],
      urlImagem: json['image'] as String,
    );
  }
}
