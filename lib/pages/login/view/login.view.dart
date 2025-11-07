// pages/login/view/login.view.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/components/terms.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import 'package:trabalho_cuidador/pages/register/view/register.view.dart';
import '../controller/login.controller.dart';
import '../components/email_input.dart';
import '../components/password_input.dart';
import '../components/login_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = LoginController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Form(
            key: _controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
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

                // Campo de Senha
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return PasswordInput(
                      controller: _controller.passwordController,
                      validator: _controller.validatePassword,
                      isPasswordVisible: _controller.isPasswordVisible,
                      onToggleVisibility: _controller.togglePasswordVisibility,
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
                return LoginButton(
                  onPressed: _controller.login,
                  isLoading: _controller.isLoading,
                );
              },
            ),
            const SizedBox(height: 12),

            // Link para criar conta
            Center(
              child: TextButton(
                onPressed: () {
                  // Navegar para página de registro
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterView()),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 18, color: AppTheme.textDark),
                    children: [
                      TextSpan(text: 'Não possui conta? '),
                      TextSpan(
                        text: 'Faça o cadastro',
                        style: TextStyle(
                          color: AppTheme.primary,
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
