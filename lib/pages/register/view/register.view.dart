// pages/register/view/register.view.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/components/terms.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import 'package:trabalho_cuidador/pages/login_page.dart';
import '../controller/register.controller.dart';
import '../../login/components/email_input.dart';
import '../../login/components/password_input.dart';
import '../components/name_input.dart';
import '../components/gender_dropdown.dart';
import '../components/comorbidity_checkbox.dart';
import '../components/register_button.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _controller = RegisterController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(backgroundColor: AppTheme.background, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return NameInput(
                      controller: _controller.nameController,
                      validator: _controller.validateName,
                    );
                  },
                ),
                const SizedBox(height: 24),

                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return EmailInput(
                      controller: _controller.emailController,
                      validator: _controller.validateEmail,
                    );
                  },
                ),
                const SizedBox(height: 24),

                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return GenderDropdown(
                      value: _controller.selectedGender,
                      options: _controller.genderOptions,
                      onChanged: _controller.setGender,
                      validator: _controller.validateGender,
                    );
                  },
                ),
                const SizedBox(height: 24),

                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return PasswordInput(
                      controller: _controller.passwordController,
                      validator: _controller.validatePassword,
                      isPasswordVisible: _controller.isPasswordVisible,
                      onToggleVisibility: _controller.togglePasswordVisibility,
                      label: 'Senha:',
                    );
                  },
                ),
                const SizedBox(height: 24),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return PasswordInput(
                      controller: _controller.confirmPasswordController,
                      validator: _controller.validateConfirmPassword,
                      isPasswordVisible: _controller.isConfirmPasswordVisible,
                      onToggleVisibility:
                          _controller.toggleConfirmPasswordVisibility,
                      label: 'Confirmar senha:',
                    );
                  },
                ),
                const SizedBox(height: 24),

                Text(
                  'Comorbidades:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return Column(
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Terms(),
            const SizedBox(height: 12),

            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return RegisterButton(
                  onPressed: () async => await _controller.register(),
                  isLoading: _controller.isLoading,
                );
              },
            ),
            const SizedBox(height: 12),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginView()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 16),
                    children: [
                      const TextSpan(text: 'Já possui conta? '),
                      TextSpan(
                        text: 'Faça o login',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
