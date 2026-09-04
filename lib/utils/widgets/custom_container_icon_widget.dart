import 'package:chat_boot/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomContainerIconWidget extends StatelessWidget {
  final IconData icon;
  final double? size;
  final void Function()? onTap;
  const CustomContainerIconWidget({
    super.key,
    required this.icon,
    this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: size ?? 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
