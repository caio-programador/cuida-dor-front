// pages/login/components/password_input.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPasswordVisible;
  final VoidCallback onToggleVisibility;
  final String label;

  const PasswordInput({
    super.key,
    required this.controller,
    this.validator,
    required this.isPasswordVisible,
    required this.onToggleVisibility,
    this.label = 'Senha:',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            hintText: '...',
            hintStyle: TextStyle(color: AppTheme.secondary),
            border: const UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.secondary),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primary),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.redDanger),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppTheme.textDark,
              ),
              onPressed: onToggleVisibility,
            ),
          ),
        ),
      ],
    );
  }
}
