import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import 'package:trabalho_cuidador/pages/home/view/home.view.dart';
import 'package:trabalho_cuidador/pages/login/view/login.view.dart';
import 'package:trabalho_cuidador/providers/accessibility_provider.dart';
import 'services/auth_service.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AccessibilityProvider(),
      child: const MyApp(),
    ),
  );
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
    await dotenv.load(fileName: ".env");
    await Future.delayed(const Duration(seconds: 2));
    final logged = await AuthService.isUserLoggedIn();
    setState(() => isLoggedIn = logged);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccessibilityProvider>(
      builder: (context, accessibility, _) {
        // Seleciona tema base (normal ou alto contraste)
        final baseTheme = accessibility.highContrast
            ? AppTheme.highContrastTheme
            : AppTheme.lightTheme;

        // Cria textTheme com font sizes garantidos
        final baseTextTheme = baseTheme.textTheme;
        final scaledTextTheme = TextTheme(
          displayLarge: _scaleTextStyle(
            baseTextTheme.displayLarge,
            accessibility.fontSizeMultiplier,
          ),
          displayMedium: _scaleTextStyle(
            baseTextTheme.displayMedium,
            accessibility.fontSizeMultiplier,
          ),
          displaySmall: _scaleTextStyle(
            baseTextTheme.displaySmall,
            accessibility.fontSizeMultiplier,
          ),
          headlineLarge: _scaleTextStyle(
            baseTextTheme.headlineLarge,
            accessibility.fontSizeMultiplier,
          ),
          headlineMedium: _scaleTextStyle(
            baseTextTheme.headlineMedium,
            accessibility.fontSizeMultiplier,
          ),
          headlineSmall: _scaleTextStyle(
            baseTextTheme.headlineSmall,
            accessibility.fontSizeMultiplier,
          ),
          titleLarge: _scaleTextStyle(
            baseTextTheme.titleLarge,
            accessibility.fontSizeMultiplier,
          ),
          titleMedium: _scaleTextStyle(
            baseTextTheme.titleMedium,
            accessibility.fontSizeMultiplier,
          ),
          titleSmall: _scaleTextStyle(
            baseTextTheme.titleSmall,
            accessibility.fontSizeMultiplier,
          ),
          bodyLarge: _scaleTextStyle(
            baseTextTheme.bodyLarge,
            accessibility.fontSizeMultiplier,
          ),
          bodyMedium: _scaleTextStyle(
            baseTextTheme.bodyMedium,
            accessibility.fontSizeMultiplier,
          ),
          bodySmall: _scaleTextStyle(
            baseTextTheme.bodySmall,
            accessibility.fontSizeMultiplier,
          ),
          labelLarge: _scaleTextStyle(
            baseTextTheme.labelLarge,
            accessibility.fontSizeMultiplier,
          ),
          labelMedium: _scaleTextStyle(
            baseTextTheme.labelMedium,
            accessibility.fontSizeMultiplier,
          ),
          labelSmall: _scaleTextStyle(
            baseTextTheme.labelSmall,
            accessibility.fontSizeMultiplier,
          ),
        );

        return MaterialApp(
          title: 'CuidaDor',
          theme: baseTheme.copyWith(textTheme: scaledTextTheme),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('pt', 'BR')],
          locale: const Locale('pt', 'BR'),
          home: isLoggedIn == null
              ? const Scaffold(body: Center(child: CircularProgressIndicator()))
              : isLoggedIn!
              ? const HomeView()
              : const LoginView(),
        );
      },
    );
  }

  TextStyle? _scaleTextStyle(TextStyle? style, double multiplier) {
    if (style == null) return null;
    return style.copyWith(fontSize: (style.fontSize ?? 14) * multiplier);
  }
}
