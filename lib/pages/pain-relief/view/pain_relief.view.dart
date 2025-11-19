// pages/pain-relief/view/pain_relief.view.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import 'package:trabalho_cuidador/pages/register-pain/view/register_pain.view.dart';
import 'package:trabalho_cuidador/utils/modal.dart';
import '../controller/pain_relief.controller.dart';
import '../components/technique_card.dart';
import '../components/page_indicator.dart';
import '../../check-generic/view/generic_check.view.dart';

class PainReliefView extends StatefulWidget {
  const PainReliefView({super.key});

  @override
  State<PainReliefView> createState() => _PainReliefViewState();
}

class _PainReliefViewState extends State<PainReliefView> {
  final _controller = PainReliefController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleNavigateRegisterPain() {
    Modal.redirectModal(context, const RegisterPainView());
  }

  void _handleContinue() {
    if (_controller.isLastPage) {
      Modal.redirectModal(
        context,
        GenericCheckPage(
          title: 'Sucesso ao aliviar a sua dor',
          description:
              'Dor aliviada com sucesso! Continue praticando exercícios para manter o bem-estar. Clique abaixo para voltar.',
          buttonAlleviateLabel: 'Registrar nova dor',
          onAlleviate: _handleNavigateRegisterPain,
          onHome: () => Navigator.popUntil(context, (route) => route.isFirst),
        ),
      );
    } else {
      _controller.nextPage();
    }
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
          'Aliviar Dor',
          style: TextStyle(
            color: AppTheme.textDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller.pageController,
              onPageChanged: (index) {
                setState(() {
                  _controller.goToPage(index);
                });
              },
              itemCount: _controller.totalPages,
              itemBuilder: (context, index) {
                return TechniqueCard(technique: _controller.techniques[index]);
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Indicadores de página
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return PageIndicator(
                        currentIndex: _controller.currentIndex,
                        totalPages: _controller.totalPages,
                        onPageTap: _controller.goToPage,
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Botões de navegação
                  Row(
                    children: [
                      // Botão Voltar
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          return Expanded(
                            child: OutlinedButton(
                              onPressed: _controller.currentIndex == 0
                                  ? null
                                  : _controller.previousPage,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Text(
                                'Voltar',
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: _controller.currentIndex == 0
                                          ? Colors.grey
                                          : Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 16),

                      // Botão Continuar
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          return Expanded(
                            child: ElevatedButton(
                              onPressed: _handleContinue,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Text(
                                _controller.isLastPage
                                    ? 'Finalizar'
                                    : 'Continuar',
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
