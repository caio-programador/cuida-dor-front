// pages/register-pain/components/body_selector.dart
import 'package:flutter/material.dart';
import 'package:body_part_selector/body_part_selector.dart';
import '../controller/register_pain.controller.dart';

class BodySelector extends StatelessWidget {
  final RegisterPainController controller;

  const BodySelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Onde é a dor?',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(
              color: controller.selectedLocation != null
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.shade300,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BodyPartSelectorTurnable(
              bodyParts: controller.selectedBodyParts,
              onSelectionUpdated: (selectedParts) {
                controller.selectBodyPartFromLib(selectedParts);
              },
              selectedColor: Colors.red.withOpacity(0.5),
              unselectedColor: Colors.transparent,
              unselectedOutlineColor: Colors.grey.shade400,
              labelData: const RotationStageLabelData(
                front: 'Frente',
                left: 'Esquerdo',
                right: 'Direito',
                back: 'Trás',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
