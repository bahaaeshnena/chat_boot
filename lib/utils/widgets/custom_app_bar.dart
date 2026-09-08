import 'package:chat_boot/utils/constants/assets.dart';
import 'package:chat_boot/utils/theme/app_text_style.dart';
import 'package:chat_boot/utils/widgets/custom_container_icon_widget.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.onNewChat});

  final VoidCallback? onNewChat;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(Assets.assetsImagesChatBotAvatar),
          ),
          const SizedBox(width: 10),
          Text.rich(
            TextSpan(
              text: 'Boot',
              style: AppTextStyle.title.copyWith(
                color: Colors.black,
                fontSize: 24,
              ),
              children: [
                TextSpan(
                  text: ' AI',
                  style: AppTextStyle.title.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
          const Spacer(),
          CustomContainerIconWidget(icon: Icons.add, onTap: onNewChat),
          const SizedBox(width: 10),
          const Icon(Icons.more_vert, color: Colors.black),
        ],
      ),
    );
  }
}
