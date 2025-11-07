// pages/register/components/name_input.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';

class NameInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const NameInput({super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nome:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: 'João...',
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
          ),
        ),
      ],
    );
  }
}
