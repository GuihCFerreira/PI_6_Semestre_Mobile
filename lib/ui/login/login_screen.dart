import 'package:flutter/material.dart';
import 'package:iplay/core/functions/theme_colors.dart';
import 'package:iplay/ui/inicio/inicio_presenter.dart';
import 'package:iplay/ui/login/login_controller.dart';
import 'package:iplay/ui/widgets/botao_padrao.dart';
import 'package:iplay/ui/widgets/input_padrao.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller;
  const LoginScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 32),
            InputPadrao(
              controller: controller.emailController,
              label: 'Email',
              hintText: 'Ex: joao@gmail.com',
              prefixIcon: Icons.email,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                  return 'Email inválido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            InputPadrao(
              controller: controller.senhaController,
              label: 'Senha',
              obscureText: !controller.senhaIsVisivel,
              hintText: 'Mínimo 8 caracteres',
              prefixIcon: Icons.lock,
              suffixIcon: IconButton(
                icon: Icon(
                  controller.senhaIsVisivel ? Icons.visibility : Icons.visibility_off,
                  color: ThemeColors.primary,
                ),
                onPressed: () {
                  controller.toggleSenhaVisivel();
                },
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                if (value.length < 8) {
                  return 'A senha deve ter pelo menos 8 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            BotaoPadrao(
              onPressed: () async {
                final resposta = await controller.login();
                if (resposta) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InicioPresenter(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                  );
                }
              },
              label: "Entrar",
              buttonIsLoading: controller.botaoIsLoading,
            ),
          ],
        ),
      ),
    ));
  }
}
