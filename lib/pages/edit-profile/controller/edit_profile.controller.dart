// pages/edit-profile/controller/edit_profile.controller.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/models/user.dart';
import 'package:trabalho_cuidador/services/user_service.dart';

class EditProfileController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _isLoadingProfile = true;

  String? _selectedGender;
  final List<String> _selectedComorbidities = [];

  bool get isNewPasswordVisible => _isNewPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get isLoading => _isLoading;
  bool get isLoadingProfile => _isLoadingProfile;
  String? get selectedGender => _selectedGender;
  List<String> get selectedComorbidities => _selectedComorbidities;
  late User user;

  final List<String> genderOptions = ['Masculino', 'Feminino', 'Outro'];
  final List<String> comorbidityOptions = [
    'Artrite',
    'Doenças reumáticas',
    'Outra',
  ];

  void toggleNewPasswordVisibility() {
    _isNewPasswordVisible = !_isNewPasswordVisible;
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

  Future<void> loadUserProfile() async {
    _isLoadingProfile = true;
    notifyListeners();

    try {
      user = await UserService.getProfile();
      nameController.text = user.name ?? '';
      emailController.text = user.email ?? '';

      if (user.sex != null) {
        switch (user.sex!) {
          case SexUser.masculino:
            _selectedGender = 'Masculino';
            break;
          case SexUser.feminino:
            _selectedGender = 'Feminino';
            break;
          case SexUser.naoInformar:
            _selectedGender = 'Outro';
            break;
        }
      }
      if (user.comorbidities != null && user.comorbidities!.isNotEmpty) {
        _selectedComorbidities.clear();
        _selectedComorbidities.addAll(
          user.comorbidities!.split(',').map((e) => e.trim()).toList(),
        );
      }
    } catch (e) {
      print('Erro ao carregar perfil: $e');
    } finally {
      _isLoadingProfile = false;
      notifyListeners();
    }
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

  String? validateNewPassword(String? value) {
    // Senha é opcional na edição
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    // Se não digitou nova senha, não precisa confirmar
    if (newPasswordController.text.isEmpty) {
      return null;
    }

    if (value == null || value.isEmpty) {
      return 'Por favor, confirme sua senha';
    }

    if (value != newPasswordController.text) {
      return 'As senhas não coincidem';
    }

    return null;
  }

  Future<bool> updateProfile() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    String comorbidades = _selectedComorbidities.join(", ");

    try {
      final updateData = {
        "id": user.id,
        "name": nameController.text,
        "email": emailController.text,
        "sex": _selectedGender?.toLowerCase(),
        "comorbidades": comorbidades,
      };

      // Apenas adiciona senha se foi digitada
      if (newPasswordController.text.isNotEmpty) {
        updateData["password"] = newPasswordController.text;
      }

      await UserService.updateProfile(updateData);
      return true;
    } catch (e) {
      print('Erro ao atualizar perfil: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
