import 'package:flutter/material.dart';
import 'package:iplay/core/functions/theme_colors.dart';
import 'package:iplay/ui/cadastro/cadastro_presenter.dart';
import 'package:iplay/ui/login/login_presenter.dart';
import 'package:iplay/ui/widgets/background.dart';
import 'package:iplay/ui/widgets/botao_padrao.dart';

class BemVindoScreen extends StatelessWidget {
  const BemVindoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Center(
                child: Image.asset(
                  'assets/images/bem_vindo.png',
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Bem Vindo ao IPlay',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Text(
                'Descubra qual jogo mais combina com você!',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),
              BotaoPadrao(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPresenter()));
                  },
                  label: "Fazer Login"),
              const SizedBox(height: 16),
              BotaoPadrao(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CadastroPresenter()));
                },
                label: "Criar Conta",
                color: ThemeColors.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
