import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import '../models/info_page.model.dart';

class InfoCard extends StatelessWidget {
  final InfoPage info;

  const InfoCard({super.key, required this.info});

  List<Widget> _buildStyledContent(String content, BuildContext context) {
    final widgets = <Widget>[];
    final lines = content.split('\n');

    for (var line in lines) {
      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      if (line.contains('**')) {
        final cleanText = line.replaceAll('**', '');
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              cleanText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      } else if (line.trim().startsWith('•') ||
          line.trim().startsWith('🔴') ||
          line.trim().startsWith('🟢') ||
          RegExp(
            r'^[\u{1F300}-\u{1F9FF}]',
            unicode: true,
          ).hasMatch(line.trim())) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    line.trim(),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: AppTheme.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (line.contains('⚠️') || line.contains('URGENTE')) {
        widgets.add(
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Text(
              line.trim(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800,
              ),
            ),
          ),
        );
      } else if (line.contains('💡') || line.contains('🎯')) {
        widgets.add(
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Text(
              line.trim(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade900,
              ),
            ),
          ),
        );
      } else {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              line.trim(),
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: AppTheme.textDark,
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Theme.of(context).colorScheme.primary.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  info.icon,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    info.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          ..._buildStyledContent(info.content, context),
        ],
      ),
    );
  }
}
