import 'package:dio/dio.dart';
import 'package:iplay/core/dtos/recomendacao.dart';
import 'package:iplay/core/dtos/usuario_dto.dart';
import 'package:iplay/core/functions/limitador_requisicoes.dart';
import 'package:iplay/core/providers/user_provider.dart';
import 'package:iplay/core/services/api_client.dart';

class UsuariosRepository {
  final ApiClient apiClient;
  final UserProvider userProvider;

  UsuariosRepository({required this.apiClient, required this.userProvider});

  Future<void> cadastrarUsuario(Map<String, dynamic> usuario) async {
    LimitadorRequisicoes.instance.verificar(acao: '/sign-up');
    await apiClient.post(
      '/sign-in',
      data: usuario,
    );
  }

  Future<UsuarioDto> login({required String email, required String senha}) async {
    LimitadorRequisicoes.instance.verificar(acao: '/login');
    final response = await apiClient.post(
      '/login',
      data: {
        'email': email,
        'password': senha,
      },
    );
    return UsuarioDto.fromJson(response.data);
  }

  Future<List<RecomendacaoDto>> recomendacoesJogos() async {
    LimitadorRequisicoes.instance.verificar(acao: '/games/recomendations');

    final options = Options(
      headers: {
        'Authorization': 'Bearer ${userProvider.userAutenticado.token}',
      },
    );

    final response = await apiClient.get(
      '/games/recomendations',
      options: options,
    );

    final recomendacoesData = response.data as List<dynamic>;
    List<RecomendacaoDto> recomendacoes = recomendacoesData.map((json) => RecomendacaoDto.fromJson(json as Map<String, dynamic>)).toList();
    return recomendacoes;
  }
}
