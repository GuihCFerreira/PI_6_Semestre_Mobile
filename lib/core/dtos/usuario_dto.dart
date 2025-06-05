class UsuarioDto {
  final String id;
  final String nome;
  final String email;
  final String token;

  UsuarioDto({
    required this.id,
    required this.nome,
    required this.email,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nome,
      'email': email,
      'token': token,
    };
  }

  factory UsuarioDto.fromJson(Map<String, dynamic> json) {
    return UsuarioDto(
      id: json['id'] as String,
      nome: json['name'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
    );
  }
}
