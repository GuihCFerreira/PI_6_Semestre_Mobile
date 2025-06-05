import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:iplay/ui/bem_vindo/bem_vindo_screen.dart';

class RedirecionamentoScreen extends StatefulWidget {
  const RedirecionamentoScreen({super.key});

  @override
  State<RedirecionamentoScreen> createState() => _RedirecionamentoScreenState();
}

class _RedirecionamentoScreenState extends State<RedirecionamentoScreen> {
  @override
  void initState() {
    FlutterNativeSplash.remove();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BemVindoScreen();
  }
}
