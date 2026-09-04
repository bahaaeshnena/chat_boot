import 'package:chat_boot/utils/theme/app_colors.dart';
import 'package:chat_boot/utils/widgets/custom_app_bar.dart';
import 'package:chat_boot/views/chat/widgets/chat_bubble.dart';
import 'package:chat_boot/views/chat/widgets/section_send_message.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: ChatBubble(
              message: 'Hello, how can I assist you today?',
              time: '10:30 AM',
            ),
          ),
        ],
      ),

      bottomNavigationBar: SectionSendMessage(),
    );
  }
}
