// pages/register-pain/components/register_pain_button.dart
import 'package:flutter/material.dart';
import '../controller/register_pain.controller.dart';

class RegisterPainButton extends StatelessWidget {
  final RegisterPainController controller;
  final VoidCallback onSuccess;

  const RegisterPainButton({
    super.key,
    required this.controller,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.canRegister
            ? () async {
                final success = await controller.registerPain();
                if (success && context.mounted) {
                  onSuccess();
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          disabledBackgroundColor: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          'Registrar Dor',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: controller.canRegister ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
