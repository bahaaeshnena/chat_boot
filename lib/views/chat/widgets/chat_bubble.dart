import 'package:chat_boot/utils/theme/app_colors.dart';
import 'package:chat_boot/utils/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
  });

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        padding: const EdgeInsets.fromLTRB(18, 14, 14, 10),
        decoration: BoxDecoration(
          color: AppColors.colorChatBubble,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'You',
                  style: AppTextStyle.input.copyWith(
                    fontSize: 14,
                  ),
                ),
                const Icon(
                  Icons.more_vert,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              message,
              style: AppTextStyle.body.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    time,
                    style: AppTextStyle.body.copyWith(
                      color: Color(0xff8E8A9D),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.done_all,
                    color: AppColors.primaryColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
