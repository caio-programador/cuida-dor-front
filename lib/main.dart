// main.dart
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
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
      title: 'Appzão Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isLoggedIn == null
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : isLoggedIn!
          ? const HomePage()
          : const LoginPage(),
    );
  }
}
