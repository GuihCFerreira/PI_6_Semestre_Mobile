import 'package:iplay/core/dtos/usuario_dto.dart';

class UserProvider {
  UsuarioDto? _user;
  UsuarioDto get userAutenticado => _user!;

  void setUser(UsuarioDto user) {
    _user = user;
  }
}
