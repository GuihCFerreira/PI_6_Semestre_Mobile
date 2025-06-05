import 'package:get_it/get_it.dart';
import 'package:iplay/core/providers/user_provider.dart';
import 'package:iplay/core/repositories/perguntas_repository.dart';
import 'package:iplay/core/repositories/usuarios_repository.dart';
import 'package:iplay/core/services/api_client.dart';
import 'package:iplay/core/services/dio_config.dart';
import 'package:iplay/core/services/snackbar_service.dart';

final getIt = GetIt.instance;

Future<void> injecaoDependencias() async {
  await getIt.reset();
  getIt.registerSingleton<SnackBarService>(SnackBarService());
  getIt.registerSingleton<ApiClient>(ApiClient(dio: DioConfig.dio));
  getIt.registerSingleton(UserProvider());

  getIt.registerSingleton<UsuariosRepository>(
    UsuariosRepository(
      apiClient: getIt<ApiClient>(),
      userProvider: getIt<UserProvider>(),
    ),
  );
  getIt.registerSingleton<PerguntasRepository>(
    PerguntasRepository(
      apiClient: getIt<ApiClient>(),
      userProvider: getIt<UserProvider>(),
    ),
  );
}
