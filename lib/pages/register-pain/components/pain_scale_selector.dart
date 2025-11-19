// pages/register-pain/components/pain_scale_selector.dart
import 'package:flutter/material.dart';
import '../controller/register_pain.controller.dart';

class PainScaleSelector extends StatelessWidget {
  final RegisterPainController controller;

  const PainScaleSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Como está sua dor?',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: PainLevel.values.map((level) {
            final isSelected = controller.selectedPainLevel == level;
            return GestureDetector(
              onTap: () => controller.selectPainLevel(level),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? level.color
                          : level.color.withOpacity(0.3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? level.color : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: Center(child: _buildEmoji(level)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    level.label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 9,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? level.color : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEmoji(PainLevel level) {
    String emoji;
    switch (level) {
      case PainLevel.semDor:
        emoji = '😊';
        break;
      case PainLevel.leve:
        emoji = '🙂';
        break;
      case PainLevel.moderada:
        emoji = '😐';
        break;
      case PainLevel.severa:
        emoji = '😟';
        break;
      case PainLevel.pior:
        emoji = '😣';
        break;
    }
    return Text(emoji, style: const TextStyle(fontSize: 28));
  }
}
