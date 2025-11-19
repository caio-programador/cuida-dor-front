// pages/register-pain/components/location_dropdown.dart
import 'package:flutter/material.dart';
import '../controller/register_pain.controller.dart';

class LocationDropdown extends StatelessWidget {
  final RegisterPainController controller;

  const LocationDropdown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            'Clique no corpo ou selecione aqui',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
          ),
          value: controller.selectedLocation,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).iconTheme.color,
          ),
          items: controller.locations.map((String location) {
            return DropdownMenuItem<String>(
              value: location,
              child: Text(
                location,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            controller.selectLocation(newValue);
          },
        ),
      ),
    );
  }
}
