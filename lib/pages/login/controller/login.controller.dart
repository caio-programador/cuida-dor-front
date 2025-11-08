// pages/login/controller/login.controller.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/pages/home/view/home.view.dart';
import 'package:trabalho_cuidador/services/auth_service.dart';

class LoginController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoading => _isLoading;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu email';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, insira um email válido';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua senha';
    }

    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }

    return null;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // Simula chamada ao backend
      await Future.delayed(const Duration(seconds: 2));

      await AuthService.login(emailController.text, passwordController.text);
      Navigator.pushReplacement(
        formKey.currentContext!,
        MaterialPageRoute(builder: (_) => const HomeView()),
      );

      // Aqui você fará a chamada real ao AuthService
      // final success = await AuthService.login(
      //   emailController.text,
      //   passwordController.text,
      // );

      print('Email: ${emailController.text}');
      print('Password: ${passwordController.text}');

      // Simula sucesso
      // if (success) { ... }
    } catch (e) {
      print('Erro ao fazer login: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
