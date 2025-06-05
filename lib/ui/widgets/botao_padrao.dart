import 'package:flutter/material.dart';
import 'package:iplay/core/functions/theme_colors.dart';

class BotaoPadrao extends StatelessWidget {
  final bool buttonIsLoading;
  final Function onPressed;
  final String label;
  final double height;
  final Color? color;
  final Widget? icon;
  const BotaoPadrao({
    super.key,
    required this.onPressed,
    required this.label,
    this.buttonIsLoading = false,
    this.color = ThemeColors.primary,
    this.height = 52,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ElevatedButton(
          onPressed: buttonIsLoading
              ? null // Desativa o botão durante o carregamento
              : () => onPressed(),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            minimumSize: Size(buttonIsLoading ? 100 : constraints.maxWidth, height),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonIsLoading ? 100 : 6),
            ),
            overlayColor: Colors.white,
          ),
          child: buttonIsLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white), strokeWidth: 2.0),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      const SizedBox(width: 8),
                    ],
                    Text(label, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
        );
      },
    );
  }
}
