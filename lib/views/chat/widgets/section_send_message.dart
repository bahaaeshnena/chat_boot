import 'package:chat_boot/utils/widgets/custom_container_icon_widget.dart';
import 'package:chat_boot/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SectionSendMessage extends StatelessWidget {
  const SectionSendMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomTextField(
                hintText: 'Ask me anything...',
                suffixIcon: const Icon(
                  Icons.attach_file,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 10),
            CustomContainerIconWidget(
              icon: Icons.send,
            ),
          ],
        ),
      ),
    );
  }
}
