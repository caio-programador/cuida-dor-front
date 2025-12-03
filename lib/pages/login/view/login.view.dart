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

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterView()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    children: [
                      const TextSpan(text: 'Não possui conta? '),
                      TextSpan(
                        text: 'Faça o cadastro',
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
