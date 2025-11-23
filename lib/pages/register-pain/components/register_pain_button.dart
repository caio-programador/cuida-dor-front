// pages/register-pain/components/register_pain_button.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/pages/error_generic_page.dart';
import 'package:trabalho_cuidador/utils/modal.dart';
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
                } else {
                  Modal.redirectModal(
                    context,
                    ErrorGenericView(
                      onGoHome: () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                      onRetry: () => Navigator.pop(context),
                    ),
                  );
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
        child: controller.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Registrar Dor',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: controller.canRegister
                      ? Colors.white
                      : Colors.grey.shade600,
                ),
              ),
      ),
    );
  }
}
