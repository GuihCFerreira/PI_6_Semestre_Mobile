import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class SnackBarService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static OverlayEntry? _currentOverlay;

  void showMessage({
    required String message,
    required Color color,
    int duration = 2500,
  }) {
    if (navigatorKey.currentState == null) {
      developer.log("Erro: NavigatorState não disponível.");
      return;
    }

    _removeCurrentOverlay();
    
    _currentOverlay = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + AppBar().preferredSize.height + 16,
        left: 10,
        right: 10,
        child: Material(
          color: Colors.transparent,
          elevation: 6.0, // Adiciona elevação para melhor efeito de sombra
          borderRadius: BorderRadius.circular(4), // Adiciona o borderRadius no Material
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

    // Insere o novo OverlayEntry
    final overlayState = navigatorKey.currentState!.overlay;
    if (overlayState != null) {
      try {
        overlayState.insert(_currentOverlay!);
        Future.delayed(Duration(milliseconds: duration), () {
          _removeCurrentOverlay();
        });
      } catch (e) {
        developer.log("Erro ao inserir overlay: $e");
        _removeCurrentOverlay();
      }
    } else {
      developer.log("Erro: OverlayState não disponível.");
      _currentOverlay = null;
    }
  }

  void _removeCurrentOverlay() {
    if (_currentOverlay != null) {
      try {
        _currentOverlay!.remove();
      } catch (e) {
        developer.log("Erro ao remover overlay: $e");
      }
      _currentOverlay = null;
    }
  }
}