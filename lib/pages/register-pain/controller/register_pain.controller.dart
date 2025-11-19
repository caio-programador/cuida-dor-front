// pages/register-pain/controller/register_pain.controller.dart
import 'package:flutter/material.dart';

enum PainLevel {
  semDor(0, 'SEM DOR', Color(0xFF4ECDC4)),
  leve(2, 'LEVE', Color(0xFF95E1A3)),
  moderada(5, 'MODERADA', Color(0xFFFDD835)),
  severa(7, 'SEVERA', Color(0xFFFFB74D)),
  pior(10, 'PIOR', Color(0xFFEF5350));

  final int value;
  final String label;
  final Color color;

  const PainLevel(this.value, this.label, this.color);
}

class BodyPart {
  final String id;
  final String name;
  final String frontOrBack; // 'front' ou 'back'

  BodyPart({required this.id, required this.name, required this.frontOrBack});
}

class RegisterPainController extends ChangeNotifier {
  String? _selectedBodyPart;
  String? _selectedLocation;
  PainLevel? _selectedPainLevel;
  double _painIntensity = 0;
  bool _isBackView = false;
  Offset? _tapPosition;

  String? get selectedBodyPart => _selectedBodyPart;
  String? get selectedLocation => _selectedLocation;
  PainLevel? get selectedPainLevel => _selectedPainLevel;
  double get painIntensity => _painIntensity;
  bool get isBackView => _isBackView;
  Offset? get tapPosition => _tapPosition;
  bool get canRegister =>
      _selectedBodyPart != null &&
      _selectedLocation != null &&
      _selectedPainLevel != null;

  // Lista de localizações para o dropdown
  final List<String> locations = [
    'Cabeça',
    'Pescoço',
    'Ombro Direito',
    'Ombro Esquerdo',
    'Braço Direito',
    'Braço Esquerdo',
    'Cotovelo Direito',
    'Cotovelo Esquerdo',
    'Antebraço Direito',
    'Antebraço Esquerdo',
    'Pulso Direito',
    'Pulso Esquerdo',
    'Mão Direita',
    'Mão Esquerda',
    'Peito',
    'Abdômen',
    'Costas Superior',
    'Costas Média',
    'Costas Inferior',
    'Quadril Direito',
    'Quadril Esquerdo',
    'Coxa Direita',
    'Coxa Esquerda',
    'Joelho Direito',
    'Joelho Esquerdo',
    'Panturrilha Direita',
    'Panturrilha Esquerda',
    'Tornozelo Direito',
    'Tornozelo Esquerdo',
    'Pé Direito',
    'Pé Esquerdo',
  ];

  void toggleBodyView() {
    _isBackView = !_isBackView;
    notifyListeners();
  }

  void selectBodyPartFromTap(Offset localPosition, Size imageSize) {
    // Normaliza as coordenadas (0 a 1)
    final normalizedX = localPosition.dx / imageSize.width;
    final normalizedY = localPosition.dy / imageSize.height;

    String? detectedPart;

    if (_isBackView) {
      // Lógica para vista de costas
      detectedPart = _detectBackBodyPart(normalizedX, normalizedY);
    } else {
      // Lógica para vista frontal
      detectedPart = _detectFrontBodyPart(normalizedX, normalizedY);
    }

    if (detectedPart != null) {
      _selectedBodyPart = detectedPart;
      _selectedLocation = detectedPart;
      _tapPosition = localPosition;
      notifyListeners();
    }
  }

  String? _detectFrontBodyPart(double x, double y) {
    // Detecção com áreas ampliadas para facilitar cliques
    // Ordem: extremidades e áreas específicas primeiro

    // Mãos (expandidas para facilitar clique)
    if (y >= 0.54 && y < 0.68 && x >= 0.68 && x <= 0.92) return 'Mão Direita';
    if (y >= 0.54 && y < 0.68 && x >= 0.08 && x <= 0.32) return 'Mão Esquerda';

    // Pés (expandidos para facilitar clique)
    if (y >= 0.88 && y <= 1.0 && x >= 0.48 && x <= 0.65) return 'Pé Direito';
    if (y >= 0.88 && y <= 1.0 && x >= 0.35 && x <= 0.52) return 'Pé Esquerdo';

    // Cabeça (expandida)
    if (y >= 0.0 && y < 0.13 && x >= 0.37 && x <= 0.63) return 'Cabeça';

    // Pescoço
    if (y >= 0.13 && y < 0.18 && x >= 0.40 && x <= 0.60) return 'Pescoço';

    // Ombros (expandidos lateralmente)
    if (y >= 0.17 && y < 0.26 && x >= 0.63 && x <= 0.85) return 'Ombro Direito';
    if (y >= 0.17 && y < 0.26 && x >= 0.15 && x <= 0.37) {
      return 'Ombro Esquerdo';
    }

    // Braços superiores (expandidos)
    if (y >= 0.26 && y < 0.42 && x >= 0.65 && x <= 0.88) return 'Braço Direito';
    if (y >= 0.26 && y < 0.42 && x >= 0.12 && x <= 0.35) {
      return 'Braço Esquerdo';
    }

    // Cotovelos (nova área para facilitar)
    if (y >= 0.40 && y < 0.46 && x >= 0.68 && x <= 0.85) {
      return 'Cotovelo Direito';
    }
    if (y >= 0.40 && y < 0.46 && x >= 0.15 && x <= 0.32) {
      return 'Cotovelo Esquerdo';
    }

    // Antebraços (expandidos)
    if (y >= 0.42 && y < 0.58 && x >= 0.68 && x <= 0.90) {
      return 'Antebraço Direito';
    }
    if (y >= 0.42 && y < 0.58 && x >= 0.10 && x <= 0.32) {
      return 'Antebraço Esquerdo';
    }

    // Pulsos (nova área)
    if (y >= 0.54 && y < 0.60 && x >= 0.68 && x <= 0.85) return 'Pulso Direito';
    if (y >= 0.54 && y < 0.60 && x >= 0.15 && x <= 0.32) {
      return 'Pulso Esquerdo';
    }

    // Peito (central)
    if (y >= 0.18 && y < 0.33 && x >= 0.38 && x <= 0.62) return 'Peito';

    // Abdômen
    if (y >= 0.33 && y < 0.50 && x >= 0.38 && x <= 0.62) return 'Abdômen';

    // Quadril (região pélvica)
    if (y >= 0.50 && y < 0.58 && x >= 0.48 && x <= 0.62) {
      return 'Quadril Direito';
    }
    if (y >= 0.50 && y < 0.58 && x >= 0.38 && x <= 0.52) {
      return 'Quadril Esquerdo';
    }

    // Coxas
    if (y >= 0.58 && y < 0.73 && x >= 0.48 && x <= 0.62) return 'Coxa Direita';
    if (y >= 0.58 && y < 0.73 && x >= 0.38 && x <= 0.52) return 'Coxa Esquerda';

    // Joelhos (expandidos)
    if (y >= 0.71 && y < 0.79 && x >= 0.48 && x <= 0.62) {
      return 'Joelho Direito';
    }
    if (y >= 0.71 && y < 0.79 && x >= 0.38 && x <= 0.52) {
      return 'Joelho Esquerdo';
    }

    // Panturrilhas
    if (y >= 0.78 && y < 0.90 && x >= 0.48 && x <= 0.62) {
      return 'Panturrilha Direita';
    }
    if (y >= 0.78 && y < 0.90 && x >= 0.38 && x <= 0.52) {
      return 'Panturrilha Esquerda';
    }

    // Tornozelos (nova área)
    if (y >= 0.86 && y < 0.92 && x >= 0.48 && x <= 0.62) {
      return 'Tornozelo Direito';
    }
    if (y >= 0.86 && y < 0.92 && x >= 0.38 && x <= 0.52) {
      return 'Tornozelo Esquerdo';
    }

    return null;
  }

  String? _detectBackBodyPart(double x, double y) {
    // Vista de costas com áreas expandidas

    // Cabeça (costas)
    if (y >= 0.0 && y < 0.13 && x >= 0.37 && x <= 0.63) return 'Cabeça';

    // Pescoço (costas)
    if (y >= 0.13 && y < 0.20 && x >= 0.40 && x <= 0.60) return 'Pescoço';

    // Costas Superior (área dos ombros/trapézio)
    if (y >= 0.18 && y < 0.32 && x >= 0.35 && x <= 0.65) {
      return 'Costas Superior';
    }

    // Costas Média (região torácica)
    if (y >= 0.32 && y < 0.46 && x >= 0.35 && x <= 0.65) return 'Costas Média';

    // Costas Inferior (lombar)
    if (y >= 0.46 && y < 0.58 && x >= 0.35 && x <= 0.65) {
      return 'Costas Inferior';
    }

    // Para membros, usa a mesma lógica da vista frontal
    return _detectFrontBodyPart(x, y);
  }

  void selectLocation(String? location) {
    _selectedLocation = location;
    _selectedBodyPart = location;
    _tapPosition = null; // Limpa a posição quando seleciona via dropdown
    notifyListeners();
  }

  void selectPainLevel(PainLevel level) {
    _selectedPainLevel = level;
    _painIntensity = level.value.toDouble();
    notifyListeners();
  }

  void setPainIntensity(double value) {
    _painIntensity = value;

    // Atualiza o PainLevel baseado no valor do slider
    if (value <= 1) {
      _selectedPainLevel = PainLevel.semDor;
    } else if (value <= 3) {
      _selectedPainLevel = PainLevel.leve;
    } else if (value <= 6) {
      _selectedPainLevel = PainLevel.moderada;
    } else if (value <= 8) {
      _selectedPainLevel = PainLevel.severa;
    } else {
      _selectedPainLevel = PainLevel.pior;
    }

    notifyListeners();
  }

  Future<bool> registerPain() async {
    if (!canRegister) return false;

    // Aqui você faria a chamada para a API
    // Por enquanto, apenas simula um delay
    await Future.delayed(const Duration(seconds: 1));

    // Sucesso - limpa os dados
    reset();
    return true;
  }

  void reset() {
    _selectedBodyPart = null;
    _selectedLocation = null;
    _selectedPainLevel = null;
    _painIntensity = 0;
    _tapPosition = null;
    notifyListeners();
  }
}
