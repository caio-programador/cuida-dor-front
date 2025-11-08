// main.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import 'package:trabalho_cuidador/pages/home/view/home.view.dart';
import 'package:trabalho_cuidador/pages/login/view/login.view.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    final logged = await AuthService.isUserLoggedIn();
    setState(() => isLoggedIn = logged);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CuidaDor',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: isLoggedIn == null
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : isLoggedIn!
          ? const HomeView()
          : const LoginView(),
    );
  }
}
