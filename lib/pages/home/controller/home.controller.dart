// pages/home/controller/home.controller.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/models/user.dart';
import 'package:trabalho_cuidador/services/user_service.dart';

class HomeController extends ChangeNotifier {
  // Simulação: true = tem dados, false = não tem dados
  bool _hasPainData = false;
  String _userName = 'Usuário';
  String? _chartImageUrl;
  bool _isLoading = false;

  bool get hasPainData => _hasPainData;
  String get userName => _userName;
  String? get chartImageUrl => _chartImageUrl;
  bool get isLoading => _isLoading;

  // Simula o carregamento dos dados do usuário
  Future<void> loadUserData() async {
    _isLoading = true;
    notifyListeners();

    // try {
    // Simula chamada ao backend
    await Future.delayed(const Duration(seconds: 1));
    User user = await UserService.getProfile();
    _userName = user.name!;
    _hasPainData = true; // Mude para false para testar o card vazio
    _chartImageUrl = null; // URL da imagem do gráfico virá do backend
    // } catch (e) {
    // print('Erro ao carregar dados da home: $e');
    // } finally {
    _isLoading = false;
    notifyListeners();
    // }
  }

  void setHasPainData(bool value) {
    _hasPainData = value;
    notifyListeners();
  }
}
