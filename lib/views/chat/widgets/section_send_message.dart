import 'package:chat_boot/utils/widgets/custom_container_icon_widget.dart';
import 'package:chat_boot/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SectionSendMessage extends StatelessWidget {
  const SectionSendMessage({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isSending,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isSending;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: CustomTextField(
                controller: controller,
                hintText: 'Ask me anything...',
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) {
                  if (!isSending) onSend();
                },
                suffixIcon: const Icon(
                  Icons.attach_file,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CustomContainerIconWidget(
                icon: isSending ? Icons.hourglass_top : Icons.send_rounded,
                onTap: isSending ? null : onSend,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
