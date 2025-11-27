// pages/edit-profile/view/edit_profile.view.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import '../controller/edit_profile.controller.dart';
import '../../login/components/email_input.dart';
import '../../login/components/password_input.dart';
import '../../register/components/name_input.dart';
import '../../register/components/gender_dropdown.dart';
import '../../register/components/comorbidity_checkbox.dart';
import '../components/save_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _controller = EditProfileController();

  @override
  void initState() {
    super.initState();
    _controller.loadUserProfile();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSave() async {
    final success = await _controller.updateProfile();
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil atualizado com sucesso!'),
          backgroundColor: AppTheme.primary,
        ),
      );
      Navigator.pop(context, true);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao atualizar perfil'),
          backgroundColor: AppTheme.redDanger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        centerTitle: true,
        actionsPadding: EdgeInsets.all(8),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: const Text(
          'Meu Perfil',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoadingProfile) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Form(
                key: _controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Campo de Nome
                    NameInput(
                      controller: _controller.nameController,
                      validator: _controller.validateName,
                    ),
                    const SizedBox(height: 24),

                    // Campo de Email
                    EmailInput(
                      controller: _controller.emailController,
                      validator: _controller.validateEmail,
                    ),
                    const SizedBox(height: 24),

                    // Dropdown de Sexo
                    GenderDropdown(
                      value: _controller.selectedGender,
                      options: _controller.genderOptions,
                      onChanged: _controller.setGender,
                      validator: _controller.validateGender,
                    ),
                    const SizedBox(height: 24),

                    // Campo de Nova Senha
                    PasswordInput(
                      controller: _controller.newPasswordController,
                      validator: _controller.validateNewPassword,
                      isPasswordVisible: _controller.isNewPasswordVisible,
                      onToggleVisibility:
                          _controller.toggleNewPasswordVisibility,
                      label: 'Nova Senha:',
                    ),
                    const SizedBox(height: 24),

                    // Confirmar Nova Senha
                    PasswordInput(
                      controller: _controller.confirmPasswordController,
                      validator: _controller.validateConfirmPassword,
                      isPasswordVisible: _controller.isConfirmPasswordVisible,
                      onToggleVisibility:
                          _controller.toggleConfirmPasswordVisibility,
                      label: 'Confirmar senha:',
                    ),
                    const SizedBox(height: 24),

                    // Comorbidades
                    Text(
                      'Comorbidades:',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: _controller.comorbidityOptions.map((
                        comorbidity,
                      ) {
                        return ComorbidityCheckbox(
                          label: comorbidity,
                          isSelected: _controller.selectedComorbidities
                              .contains(comorbidity),
                          onChanged: (_) =>
                              _controller.toggleComorbidity(comorbidity),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return SaveButton(
              onPressed: _handleSave,
              isLoading: _controller.isLoading,
            );
          },
        ),
      ),
    );
  }
}
