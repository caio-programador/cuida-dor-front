// pages/pain-relief/controller/pain_relief.controller.dart
import 'package:flutter/material.dart';

class PainReliefTechnique {
  final String title;
  final String technique;
  final String duration;
  final String benefit;
  final List<String> steps;
  final String? tip;
  final String? warning;

  PainReliefTechnique({
    required this.title,
    required this.technique,
    required this.duration,
    required this.benefit,
    required this.steps,
    this.tip,
    this.warning,
  });
}

class PainReliefController extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  int get currentIndex => _currentIndex;
  int get totalPages => techniques.length;
  bool get isLastPage => _currentIndex == techniques.length - 1;

  final List<PainReliefTechnique> techniques = [
    PainReliefTechnique(
      title: 'Alongamentos guiados',
      technique: 'Alongamento de mãos',
      duration: '5 minutos',
      benefit: 'Rigidez matinal',
      steps: [
        'Sente-se confortavelmente',
        'Abra as mãos devagar',
        'Feche formando um punho suave',
        'Repita 10 vezes',
        'Descanse',
      ],
      warning: 'Pare se sentir dor forte',
    ),
    PainReliefTechnique(
      title: 'Técnicas de respiração',
      technique: 'Respiração profunda',
      duration: '5 minutos',
      benefit: 'Reduz tensão e ansiedade',
      steps: [
        'Sente-se confortavelmente ou deite',
        'Coloque uma mão na barriga',
        'Inspire pelo nariz contando até 4',
        'Sinta a barriga subir (não o peito)',
        'Expire pela boca contando até 6',
        'Repita 10 vezes',
      ],
      tip: 'Faça antes de dormir',
    ),
    PainReliefTechnique(
      title: 'Técnicas de respiração',
      technique: 'Respiração 4-7-8',
      duration: '3-5 minutos',
      benefit: 'Acalma e melhora o sono',
      steps: [
        'Inspire pelo nariz contando até 4',
        'Segure a respiração por 7 segundos',
        'Expire pela boca por 8 segundos',
        'Repita 4 vezes com ciclos completos',
      ],
      warning: 'Pode dar leve tontura no início',
    ),
    PainReliefTechnique(
      title: 'Técnicas de respiração',
      technique: 'Suspiro de Alívio',
      duration: '2 minutos',
      benefit: 'Libera tensão rápida',
      steps: [
        'Inspire pelo nariz',
        'Abra bem a boca e solte o ar com um suspiro sonoro',
        'Deixe os ombros caírem relaxados',
        'Repita 5 vezes',
      ],
    ),
    PainReliefTechnique(
      title: 'Técnicas de respiração',
      technique: 'Relaxamento muscular',
      duration: '10-15 minutos',
      benefit: 'Alivia tensão e dor muscular',
      steps: [
        'Deite-se confortavelmente',
        'Comece pelos pés: Contraia os músculos por 5 segundos e depois relaxe completamente por 10 segundos',
        'Suba pelo corpo: panturrilhas => coxas => barriga => mãos e braços => ombros => rosto',
      ],
      warning: 'Não force articulações doloridas',
    ),
    PainReliefTechnique(
      title: 'Técnicas de respiração',
      technique: 'Toque calmante',
      duration: '5 minutos',
      benefit: 'Conforto imediato',
      steps: [
        'Esfregue as mãos até aquecê-las',
        'Coloque as mãos nos locais doloridos',
        'Faça movimentos circulares suaves',
        'Respire profundamente',
        'Imagine o calor aliviando a dor. Pode usar óleo morno',
      ],
    ),
  ];

  void nextPage() {
    if (_currentIndex < techniques.length - 1) {
      _currentIndex++;
      pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void previousPage() {
    if (_currentIndex > 0) {
      _currentIndex--;
      pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void goToPage(int index) {
    _currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
