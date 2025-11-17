// pages/accessibility/components/contrast_switch.dart
import 'package:flutter/material.dart';

class ContrastSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const ContrastSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Contraste elevado:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Theme.of(context).colorScheme.primary,
          activeTrackColor: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(0.5),
          inactiveThumbColor: Colors.grey[400],
          inactiveTrackColor: Colors.grey[300],
        ),
      ],
    );
  }
}
