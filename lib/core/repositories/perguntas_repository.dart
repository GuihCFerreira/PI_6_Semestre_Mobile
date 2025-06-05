import 'package:dio/dio.dart';
import 'package:iplay/core/dtos/jogo_dto.dart';
import 'package:iplay/core/model/pergunta_model.dart';
import 'package:iplay/core/providers/user_provider.dart';
import 'package:iplay/core/services/api_client.dart';

class PerguntasRepository {
  final ApiClient apiClient;
  final UserProvider userProvider;

  PerguntasRepository({
    required this.apiClient,
    required this.userProvider,
  });

  Future<List<PerguntaModel>> buscarPerguntas() async {
    //quero colocar bearer Token
    final options = Options(
      headers: {
        'Authorization': 'Bearer ${userProvider.userAutenticado.token}',
      },
    );
    final response = await apiClient.get('/quiz/template', options: options);
    List<PerguntaModel> perguntas = (response.data as List).map((json) => PerguntaModel.fromJson(json as Map<String, dynamic>)).toList();
    return perguntas;
  }

  Future<({List<JogoDto> jogos, bool temMaisJogos})> buscarJogos({required String? nomeJogo, required int maximoJogos}) async {
    final options = Options(
      headers: {
        'Authorization': 'Bearer ${userProvider.userAutenticado.token}',
      },
    );

    final queryParams = <String, dynamic>{
      if (maximoJogos != 0) 'perPage': maximoJogos,
      if (nomeJogo != null && nomeJogo.trim().isNotEmpty) 'search': nomeJogo,
    };

    final response = await apiClient.get(
      '/games/quiz/template',
      queryParameters: queryParams,
      options: options,
    );

    final responseData = response.data as Map<String, dynamic>;
    final jogosData = responseData['data'] as List<dynamic>;
    final bool temMaisJogos = responseData['pagination']['hasNextPage'];
    List<JogoDto> jogos = jogosData.map((json) => JogoDto.fromJson(json as Map<String, dynamic>)).toList();

    return (jogos: jogos, temMaisJogos: temMaisJogos);
  }

  Future<void> registrarQuiz(Map<String, dynamic> dados) async {
    final options = Options(
      headers: {
        'Authorization': 'Bearer ${userProvider.userAutenticado.token}',
      },
    );

    await apiClient.post('/quiz', data: dados, options: options);
  }
}
