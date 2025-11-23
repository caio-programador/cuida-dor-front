// pages/register/controller/register.controller.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/pages/home_page.dart';
import 'package:trabalho_cuidador/services/user_service.dart';

class RegisterController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  String? _selectedGender;
  final List<String> _selectedComorbidities = [];

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get isLoading => _isLoading;
  String? get selectedGender => _selectedGender;
  List<String> get selectedComorbidities => _selectedComorbidities;

  final List<String> genderOptions = ['Masculino', 'Feminino', 'Outro'];
  final List<String> comorbidityOptions = [
    'Artrite',
    'Doenças reumáticas',
    'Outra',
  ];

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  void setGender(String? value) {
    _selectedGender = value;
    notifyListeners();
  }

  void toggleComorbidity(String comorbidity) {
    if (_selectedComorbidities.contains(comorbidity)) {
      _selectedComorbidities.remove(comorbidity);
    } else {
      _selectedComorbidities.add(comorbidity);
    }
    notifyListeners();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu nome';
    }
    if (value.length < 3) {
      return 'Nome deve ter pelo menos 3 caracteres';
    }
    return null;
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

  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, selecione o sexo';
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

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, confirme sua senha';
    }

    if (value != passwordController.text) {
      return 'As senhas não coincidem';
    }

    return null;
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _isLoading = true;
    notifyListeners();
    String comorbidades = _selectedComorbidities.join(", ");

    try {
      await UserService.register({
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "sex": _selectedGender?.toLowerCase(),
        "comorbidades": comorbidades,
      });
      if (formKey.currentContext != null && formKey.currentContext!.mounted) {
        Navigator.pushReplacement(
          formKey.currentContext!,
          MaterialPageRoute(builder: (_) => const HomeView()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        formKey.currentContext!,
      ).showSnackBar(SnackBar(content: Text('Erro ao fazer registro')));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
