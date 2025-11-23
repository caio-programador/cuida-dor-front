// pages/home/controller/home.controller.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/models/user.dart';
import 'package:trabalho_cuidador/services/pain_service.dart';
import 'package:trabalho_cuidador/services/user_service.dart';

class HomeController extends ChangeNotifier {
  // Simulação: true = tem dados, false = não tem dados
  bool _hasPainData = false;
  String _userName = 'Usuário';
  String? _chartBase64;
  bool _isLoading = false;

  bool get hasPainData => _hasPainData;
  String get userName => _userName;
  String? get chartBase64 => _chartBase64;
  bool get isLoading => _isLoading;

  // Simula o carregamento dos dados do usuário
  Future<void> loadUserData() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      User user = await UserService.getProfile();
      _userName = user.name!;
    } catch (e) {
      print('Erro ao carregar dados da home: $e');
    }
    try {
      _chartBase64 = await PainService.getBase64GraphImage(size: 5);
      _hasPainData = true;
    } catch (e) {
      _hasPainData = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setHasPainData(bool value) {
    _hasPainData = value;
    notifyListeners();
  }
}
