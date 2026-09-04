import 'package:chat_boot/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DotsSection extends StatelessWidget {
  const DotsSection({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });
  final int currentPage;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: currentPage == index ? 24.0 : 12.0,
          height: 12.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: currentPage == index
                ? AppColors.primaryColor
                : Colors.grey.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
