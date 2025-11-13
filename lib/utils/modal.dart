import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';

class Modal {
  static void openFullScreen(BuildContext context, Widget child) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: AppTheme.textDark,
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) => child,
        transitionsBuilder: (_, animation, __, child) {
          final offsetAnimation =
              Tween(begin: const Offset(0, 1), end: Offset.zero).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              );

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}
