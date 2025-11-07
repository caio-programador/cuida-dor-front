// pages/register/components/terms.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import 'package:trabalho_cuidador/pages/terms/view/terms.view.dart';
import 'package:trabalho_cuidador/utils/modal.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  void _onTermsTap(BuildContext context) {
    Modal.openFullScreen(context, const TermsView());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(fontSize: 12, color: AppTheme.textDark),
          children: [
            const TextSpan(text: 'Ao continuar, você aceita os '),
            TextSpan(
              text: 'termos e condições',
              style: TextStyle(
                color: AppTheme.primary,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _onTermsTap(context),
            ),
          ],
        ),
      ),
    );
  }
}
