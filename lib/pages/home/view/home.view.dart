// pages/home/view/home.view.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import '../controller/home.controller.dart';
import '../components/home_drawer.dart';
import '../components/pain_chart.dart';
import '../components/empty_pain_card.dart';
import '../components/info_card.dart';
import '../components/action_button.dart';
import 'package:trabalho_cuidador/utils/genericError.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.loadUserData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: AppTheme.textDark),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: AppTheme.textDark),
            onPressed: () {
              // Navegar para perfil
              print('Perfil');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ErroGenericoPage(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const HomeDrawer(),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppTheme.primary),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título de boas-vindas
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                    children: [
                      TextSpan(text: 'Bem vindo ${_controller.userName} ao '),
                      TextSpan(
                        text: 'CuidaDor',
                        style: TextStyle(color: AppTheme.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 96),

                // Gráfico ou Card vazio
                _controller.hasPainData
                    ? PainChart(imageUrl: _controller.chartImageUrl)
                    : const EmptyPainCard(),
                const SizedBox(height: 24),

                // Card de informações
                GestureDetector(
                  onTap: () {
                    // Navegar para informações sobre dor
                    print('Informações sobre dor');
                  },
                  child: const InfoCard(),
                ),
                const SizedBox(height: 24),

                // Botão Registrar Dor
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ActionButton(
              text: 'Registrar Dor',
              onPressed: () {
                // Navegar para registrar dor
                print('Registrar dor');
              },
            ),
            const SizedBox(height: 16),

            // Botão Aliviar a Dor
            ActionButton(
              text: 'Aliviar a Dor',
              isPrimary: false,
              onPressed: () {
                // Navegar para aliviar dor
                print('Aliviar dor');
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
