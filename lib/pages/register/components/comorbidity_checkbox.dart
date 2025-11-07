// pages/register/components/comorbidity_checkbox.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';

class ComorbidityCheckbox extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(bool?) onChanged;

  const ComorbidityCheckbox({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: isSelected,
      onChanged: onChanged,
      title: Text(label, style: const TextStyle(fontSize: 16)),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      activeColor: AppTheme.primary,
      checkColor: AppTheme.background,
    );
  }
}
