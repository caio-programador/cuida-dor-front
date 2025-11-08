// pages/home/components/home_drawer.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import '../../login/view/login.view.dart';
import '../../../services/auth_service.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.background),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'CuidaDor',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Editar perfil'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              // Navegar para página de editar perfil
              print('Editar perfil');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Histórico das dores'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              // Navegar para página de histórico
              print('Histórico das dores');
            },
          ),
          ListTile(
            leading: const Icon(Icons.accessibility_new),
            title: const Text('Acessibilidade'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              // Navegar para página de acessibilidade
              print('Acessibilidade');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Encerrar Sessão'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              Navigator.pop(context);
              await AuthService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
