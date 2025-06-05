class ErroInterno implements Exception {
  final String message;
  ErroInterno({required this.message});

  @override
  String toString() => message;
}
