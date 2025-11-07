import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';

class Modal {
  static void openFullScreen(BuildContext context, Widget child) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false, // deixa o fundo visível
        barrierColor: AppTheme.textDark, // escurece o fundo
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) => child,
        transitionsBuilder: (_, animation, __, child) {
          final offsetAnimation =
              Tween(
                begin: const Offset(0, 1), // começa fora da tela (embaixo)
                end: Offset.zero, // termina na posição normal
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic, // curva suave e fluida
                ),
              );

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}
