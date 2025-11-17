// pages/accessibility/view/accessibility.view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import '../../../providers/accessibility_provider.dart';
import '../controller/accessibility.controller.dart';
import '../components/font_size_slider.dart';
import '../components/contrast_switch.dart';
import '../components/apply_button.dart';

class AccessibilityView extends StatefulWidget {
  const AccessibilityView({super.key});

  @override
  State<AccessibilityView> createState() => _AccessibilityViewState();
}

class _AccessibilityViewState extends State<AccessibilityView> {
  final _controller = AccessibilityController();

  @override
  void initState() {
    super.initState();
    // Carregar valores atuais do provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final accessibilityProvider = context.read<AccessibilityProvider>();
      _controller.setFontSizeValue(accessibilityProvider.fontSize);
      _controller.setHighContrast(accessibilityProvider.highContrast);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _applySettings() {
    final accessibilityProvider = context.read<AccessibilityProvider>();
    accessibilityProvider.setFontSize(_controller.fontSizeValue);
    accessibilityProvider.setHighContrast(_controller.highContrast);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Configurações aplicadas com sucesso!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        centerTitle: true,
        actionsPadding: EdgeInsets.all(8),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: const Text(
          'Acessibilidade',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Slider de tamanho de fonte
                FontSizeSlider(
                  value: _controller.fontSizeValue,
                  onChanged: _controller.setFontSizeValue,
                ),
                const SizedBox(height: 40),

                // Switch de contraste elevado
                ContrastSwitch(
                  value: _controller.highContrast,
                  onChanged: _controller.setHighContrast,
                ),
                const SizedBox(height: 60),

                // Botão aplicar
                ApplyButton(onPressed: _applySettings),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
