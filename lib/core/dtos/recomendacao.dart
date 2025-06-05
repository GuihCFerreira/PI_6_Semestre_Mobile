class RecomendacaoDto {
  final String name;
  final int idJogo;
  final String imagem;
  final String descricaoCurta;
  final DateTime dataLancamento;

  RecomendacaoDto({
    required this.name,
    required this.idJogo,
    required this.imagem,
    required this.descricaoCurta,
    required this.dataLancamento,
  });

  //fromJson
  factory RecomendacaoDto.fromJson(Map<String, dynamic> json) {
    return RecomendacaoDto(
      name: json['name'] as String,
      idJogo: json['game_id'],
      imagem: json['header_image'] as String,
      descricaoCurta: json['short_description'] as String,
      dataLancamento: DateTime.parse(json['release_date'] as String),
    );
  }
}
