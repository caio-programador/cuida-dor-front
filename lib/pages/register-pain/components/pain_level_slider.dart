// pages/register-pain/components/pain_level_slider.dart
import 'package:flutter/material.dart';
import '../controller/register_pain.controller.dart';

class PainLevelSlider extends StatelessWidget {
  final RegisterPainController controller;

  const PainLevelSlider({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Escala de referência
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(11, (index) {
              return Text(
                '$index',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: controller.painIntensity.round() == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: controller.painIntensity.round() == index
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade600,
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 8),
        // Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Theme.of(context).colorScheme.primary,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: Theme.of(context).colorScheme.primary,
            overlayColor: Theme.of(
              context,
            ).colorScheme.primary.withOpacity(0.2),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            trackHeight: 6,
          ),
          child: Slider(
            value: controller.painIntensity,
            min: 0,
            max: 10,
            divisions: 10,
            onChanged: (value) => controller.setPainIntensity(value),
          ),
        ),
        // Indicadores de valor
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color:
                    controller.selectedPainLevel?.color ?? Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                controller.painIntensity.round().toString(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              '10',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    );
  }
}
