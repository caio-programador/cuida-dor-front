// pages/home/view/home.view.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import 'package:trabalho_cuidador/pages/pain_relief_page.dart';
import 'package:trabalho_cuidador/pages/register-pain/view/register_pain.view.dart';
import 'package:trabalho_cuidador/pages/more-info/view/more_info.view.dart';
import 'package:trabalho_cuidador/pages/edit-profile/view/edit_profile.view.dart';
import 'package:trabalho_cuidador/utils/modal.dart';
import '../controller/home.controller.dart';
import '../components/home_drawer.dart';
import '../components/pain_chart.dart';
import '../components/empty_pain_card.dart';
import '../components/info_card.dart';
import '../components/action_button.dart';

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_outline,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () async {
              await Modal.openFullScreen(context, const EditProfileView());
              _controller.loadUserData();
            },
          ),
        ],
      ),
      drawer: const HomeDrawer(),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => _controller.loadUserData(),
            color: Theme.of(context).colorScheme.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título de boas-vindas
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontSize: 28, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: 'Bem vindo ${_controller.userName} ao '),
                        TextSpan(
                          text: 'CuidaDor',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 96),

                  // Gráfico ou Card vazio
                  _controller.hasPainData
                      ? PainChart(base64Image: _controller.chartBase64)
                      : const EmptyPainCard(),
                  const SizedBox(height: 24),

                  // Card de informações
                  GestureDetector(
                    onTap: () {
                      Modal.openFullScreen(context, const MoreInfoView());
                    },
                    child: const InfoCard(),
                  ),
                  const SizedBox(height: 24),

                  // Botão Registrar Dor
                ],
              ),
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
              onPressed: () async {
                await Modal.openFullScreen(
                  context,
                  const RegisterPainView(
                    entryPoint: 'BEFORE_RELIEF_TECHNIQUES',
                  ),
                );
                _controller.loadUserData();
              },
            ),
            const SizedBox(height: 16),

            // Botão Aliviar a Dor
            ActionButton(
              text: 'Aliviar a Dor',
              isPrimary: false,
              onPressed: () {
                Modal.openFullScreen(context, const PainReliefView());
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
