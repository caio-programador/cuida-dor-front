// pages/register-pain/view/register_pain.view.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import 'package:trabalho_cuidador/pages/pain_relief_page.dart';
import 'package:trabalho_cuidador/utils/modal.dart';
import '../controller/register_pain.controller.dart';
import '../components/body_selector.dart';
import '../components/location_dropdown.dart';
import '../components/pain_scale_selector.dart';
import '../components/pain_level_slider.dart';
import '../components/register_pain_button.dart';
import '../../check-generic/view/generic_check.view.dart';

class RegisterPainView extends StatefulWidget {
  const RegisterPainView({super.key, required this.entryPoint});

  final String entryPoint;

  @override
  State<RegisterPainView> createState() => _RegisterPainViewState();
}

class _RegisterPainViewState extends State<RegisterPainView> {
  late final _controller = RegisterPainController(
    entryPoint: widget.entryPoint,
  );

  void _handleNavigateAlleviate() {
    Modal.redirectModal(context, PainReliefView());
  }

  void _handleSuccess() {
    Modal.redirectModal(
      context,
      GenericCheckPage(
        title: 'Sucesso ao registrar sua dor',
        description:
            'Sua dor foi registrada. Continue monitorando seu bem-estar e registrando sempre que necessário.'
            ' Que tal tentar um exercício para aliviar a dor? Clique abaixo e bora se mexer',
        buttonAlleviateLabel: 'Aliviar dor',
        onAlleviate: () {
          _handleNavigateAlleviate();
        },
        onHome: () => Navigator.popUntil(context, (route) => route.isFirst),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actionsPadding: EdgeInsets.all(8),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ],
        title: const Text(
          'Registrar Dor',
          style: TextStyle(
            color: AppTheme.textDark,
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
                BodySelector(controller: _controller),
                const SizedBox(height: 24),

                LocationDropdown(controller: _controller),
                const SizedBox(height: 32),

                PainScaleSelector(controller: _controller),
                const SizedBox(height: 32),

                PainLevelSlider(controller: _controller),
                const SizedBox(height: 40),

                RegisterPainButton(
                  controller: _controller,
                  onSuccess: _handleSuccess,
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
