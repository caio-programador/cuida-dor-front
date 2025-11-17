// pages/home/components/home_drawer.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/utils/modal.dart';
import '../../login/view/login.view.dart';
import '../../accessibility/view/accessibility.view.dart';
import '../../../services/auth_service.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'CuidaDor',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person_outline,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Editar perfil',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              Navigator.pop(context);
              // Navegar para página de editar perfil
              print('Editar perfil');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.history,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Histórico das dores',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              Navigator.pop(context);
              // Navegar para página de histórico
              print('Histórico das dores');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.accessibility_new,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Acessibilidade',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              Navigator.pop(context);
              Modal.openFullScreen(context, const AccessibilityView());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Encerrar Sessão',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).iconTheme.color,
            ),
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
