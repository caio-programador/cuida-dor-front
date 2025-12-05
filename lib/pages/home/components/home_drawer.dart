// pages/home/components/home_drawer.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/models/user.dart';
import 'package:trabalho_cuidador/pages/edit-profile/view/edit_profile.view.dart';
import 'package:trabalho_cuidador/pages/pain-history/view/pain_history.view.dart';
import 'package:trabalho_cuidador/utils/modal.dart';
import '../../login/view/login.view.dart';
import '../../accessibility/view/accessibility.view.dart';
import '../../../services/auth_service.dart';
import '../controller/home.controller.dart';

class HomeDrawer extends StatelessWidget {
  final User? user;
  final HomeController? controller;

  const HomeDrawer({super.key, this.user, this.controller});

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

              Modal.openFullScreen(context, const EditProfileView());
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
              Modal.openFullScreen(context, const PainHistoryView());
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
          if (user?.role == 'ADMIN') ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Administração',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.file_download_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'Exportar CSV',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () async {
                Navigator.pop(context);

                if (controller == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erro ao exportar CSV'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                try {
                  // Mostra loading
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  );

                  await controller!.exportCSV();

                  // Remove loading
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('CSV exportado com sucesso!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  // Remove loading
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro ao exportar CSV: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ],
          const Divider(),
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
