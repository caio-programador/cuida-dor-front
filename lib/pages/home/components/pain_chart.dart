// pages/home/components/pain_chart.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';

class PainChart extends StatelessWidget {
  final String? base64Image;

  const PainChart({super.key, this.base64Image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: base64Image != null && base64Image!.isNotEmpty
          ? _buildBase64Image()
          : _buildPlaceholderChart(),
    );
  }

  Widget _buildBase64Image() {
    try {
      String cleanBase64 = base64Image!;
      if (cleanBase64.contains(',')) {
        cleanBase64 = cleanBase64.split(',').last;
      }

      final bytes = base64Decode(cleanBase64);
      return InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: Image.memory(
          bytes,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholderChart();
          },
        ),
      );
    } catch (e) {
      return _buildPlaceholderChart();
    }
  }

  Widget _buildPlaceholderChart() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildBar(AppTheme.primary, 120, '+2/00'),
            _buildBar(AppTheme.redDanger, 80, '-5/0'),
            _buildBar(AppTheme.primary, 140, '+3/00'),
            _buildBar(AppTheme.redDanger, 100, '-5/00'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegend(AppTheme.primary, 'Depois do exercício'),
            const SizedBox(width: 16),
            _buildLegend(AppTheme.redDanger, 'Antes do exercício'),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBar(Color color, double height, String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: AppTheme.background,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
