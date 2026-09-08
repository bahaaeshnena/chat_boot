import 'package:chat_boot/models/chat_message.dart';
import 'package:chat_boot/utils/theme/app_colors.dart';
import 'package:chat_boot/utils/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    this.onRetry,
  });

  final ChatMessage message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isFromUser;
    final time = TimeOfDay.fromDateTime(message.sentAt).format(context);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.fromLTRB(18, 14, 14, 10),
        decoration: BoxDecoration(
          color: isUser ? AppColors.colorChatBubble : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: isUser
              ? null
              : Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.12),
                ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isUser ? 'You' : 'Boot AI',
                  style: AppTextStyle.input.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isUser)
                  const Icon(
                    Icons.more_vert,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
              ],
            ),
            const SizedBox(height: 6),
            if (message.isLoading && message.text.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else
              SelectableText(
                message.text,
                style: AppTextStyle.body.copyWith(
                  color: message.isError ? Colors.red.shade700 : Colors.black,
                ),
              ),
            if (message.isLoading && message.text.isNotEmpty) ...[
              const SizedBox(height: 8),
              const LinearProgressIndicator(minHeight: 2),
            ],
            if (message.isError && onRetry != null) ...[
              const SizedBox(height: 4),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Try again'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
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
                      color: const Color(0xff8E8A9D),
                      fontSize: 12,
                    ),
                  ),
                  if (isUser) ...[
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.done_all,
                      color: AppColors.primaryColor,
                      size: 18,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
