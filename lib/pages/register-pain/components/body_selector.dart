// pages/register-pain/components/body_selector.dart
import 'package:flutter/material.dart';
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
        GestureDetector(
          onTapUp: (details) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            final localPosition = details.localPosition;

            controller.selectBodyPartFromTap(localPosition, box.size);
          },
          child: Container(
            height: 350,
            decoration: BoxDecoration(
              border: Border.all(
                color: controller.selectedBodyPart != null
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade300,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Image.asset('assets/body.png', fit: BoxFit.contain),
                  // Marcador visual da área clicada
                  if (controller.tapPosition != null)
                    Positioned(
                      left: controller.tapPosition!.dx - 30,
                      top: controller.tapPosition!.dy - 30,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withOpacity(0.3),
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
