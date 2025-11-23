// pages/register-pain/controller/register_pain.controller.dart
import 'package:flutter/material.dart';
import 'package:body_part_selector/body_part_selector.dart';
import 'package:trabalho_cuidador/services/pain_service.dart';

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
  final String frontOrBack;

  BodyPart({required this.id, required this.name, required this.frontOrBack});
}

class RegisterPainController extends ChangeNotifier {
  BodyParts _selectedBodyParts = const BodyParts();
  String? _selectedLocation;
  PainLevel? _selectedPainLevel;
  final String entryPoint;
  double _painIntensity = 0;
  bool _isLoading = false;

  BodyParts get selectedBodyParts => _selectedBodyParts;
  String? get selectedLocation => _selectedLocation;
  PainLevel? get selectedPainLevel => _selectedPainLevel;
  double get painIntensity => _painIntensity;
  bool get isLoading => _isLoading;
  bool get canRegister =>
      _selectedLocation != null && _selectedPainLevel != null && !_isLoading;

  RegisterPainController({required this.entryPoint});
  final Map<String, String> _bodyPartLabels = {
    'head': 'Cabeça',
    'neck': 'Pescoço',
    'leftShoulder': 'Ombro Esquerdo',
    'rightShoulder': 'Ombro Direito',
    'leftUpperArm': 'Braço Esquerdo',
    'rightUpperArm': 'Braço Direito',
    'leftLowerArm': 'Antebraço Esquerdo',
    'rightLowerArm': 'Antebraço Direito',
    'leftHand': 'Mão Esquerda',
    'rightHand': 'Mão Direita',
    'upperBody': 'Peito',
    'abdomen': 'Abdômen',
    'lowerBody': 'Costas Inferior',
    'leftUpperLeg': 'Coxa Esquerda',
    'rightUpperLeg': 'Coxa Direita',
    'leftKnee': 'Joelho Esquerdo',
    'rightKnee': 'Joelho Direito',
    'leftLowerLeg': 'Panturrilha Esquerda',
    'rightLowerLeg': 'Panturrilha Direita',
    'leftFoot': 'Pé Esquerdo',
    'rightFoot': 'Pé Direito',
  };

  BodyParts _createBodyPartsFromLocation(String location) {
    final id = _bodyPartLabels.entries
        .firstWhere(
          (e) => e.value == location,
          orElse: () => const MapEntry('', ''),
        )
        .key;

    if (id.isEmpty) return const BodyParts();

    return const BodyParts().withToggledId(id);
  }

  // Lista de localizações para o dropdown
  final List<String> locations = [
    'Cabeça',
    'Pescoço',
    'Ombro Direito',
    'Ombro Esquerdo',
    'Braço Direito',
    'Braço Esquerdo',
    'Antebraço Direito',
    'Antebraço Esquerdo',
    'Mão Direita',
    'Mão Esquerda',
    'Peito',
    'Abdômen',
    'Costas Inferior',
    'Coxa Direita',
    'Coxa Esquerda',
    'Joelho Direito',
    'Joelho Esquerdo',
    'Panturrilha Direita',
    'Panturrilha Esquerda',
    'Pé Direito',
    'Pé Esquerdo',
  ];

  void selectBodyPartFromLib(BodyParts selectedParts) {
    // Garante que apenas uma parte seja selecionada por vez
    final map = selectedParts.toMap();

    // Encontra a última parte clicada (a que é diferente da atual)
    String? newlySelectedId;
    final currentMap = _selectedBodyParts.toMap();

    for (var entry in map.entries) {
      if (entry.value == true && currentMap[entry.key] != true) {
        newlySelectedId = entry.key;
        break;
      }
    }

    // Se encontrou uma nova parte, seleciona apenas ela
    if (newlySelectedId != null) {
      _selectedBodyParts = const BodyParts().withToggledId(newlySelectedId);
      _selectedLocation = _bodyPartLabels[newlySelectedId];
    } else {
      // Se clicou na mesma parte, desmarca
      _selectedBodyParts = const BodyParts();
      _selectedLocation = null;
    }

    notifyListeners();
  }

  void selectLocation(String? location) {
    _selectedLocation = location;
    if (location != null) {
      _selectedBodyParts = _createBodyPartsFromLocation(location);
    } else {
      _selectedBodyParts = const BodyParts();
    }
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
    if (_selectedLocation == null || _selectedPainLevel == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      await PainService.registerPain(
        painLocale: _selectedLocation!,
        painScale: _selectedPainLevel!.value,
        type: entryPoint,
      );
      reset();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void reset() {
    _selectedBodyParts = const BodyParts();
    _selectedLocation = null;
    _selectedPainLevel = null;
    _painIntensity = 0;
    _isLoading = false;
    notifyListeners();
  }
}
