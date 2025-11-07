// pages/register/components/gender_dropdown.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';

class GenderDropdown extends StatelessWidget {
  final String? value;
  final List<String> options;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const GenderDropdown({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sexo:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          validator: validator,
          decoration: InputDecoration(
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
          hint: Text('Selecione', style: TextStyle(color: AppTheme.secondary)),
          items: options.map((String option) {
            return DropdownMenuItem<String>(value: option, child: Text(option));
          }).toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.arrow_drop_down),
        ),
      ],
    );
  }
}
