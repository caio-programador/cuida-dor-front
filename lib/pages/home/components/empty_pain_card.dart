// pages/home/components/empty_pain_card.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';

class EmptyPainCard extends StatelessWidget {
  const EmptyPainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.secondary),
      ),
      child: Column(
        children: [
          Icon(Icons.bar_chart_outlined, size: 80, color: AppTheme.secondary),
          const SizedBox(height: 16),
          Text(
            'Nenhuma dor registrada',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.terciary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Comece registrando sua primeira dor\npara visualizar o gráfico',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.terciary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
