// pages/pain-relief/components/page_indicator.dart
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalPages;
  final Function(int) onPageTap;

  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.totalPages,
    required this.onPageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        return GestureDetector(
          onTap: () => onPageTap(index),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: currentIndex == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
