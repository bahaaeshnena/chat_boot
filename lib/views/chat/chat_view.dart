import 'package:chat_boot/models/chat_message.dart';
import 'package:chat_boot/services/gemini_chat_service.dart';
import 'package:chat_boot/utils/theme/app_colors.dart';
import 'package:chat_boot/utils/widgets/custom_app_bar.dart';
import 'package:chat_boot/views/chat/widgets/chat_bubble.dart';
import 'package:chat_boot/views/chat/widgets/section_send_message.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, this.chatService});

  final ChatService? chatService;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  static const _welcomeMessage = 'Hello, how can I assist you today?';

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final ChatService _chatService;
  late final List<ChatMessage> _messages;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _chatService = widget.chatService ?? GeminiChatService();
    _messages = [_createWelcomeMessage()];
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  ChatMessage _createWelcomeMessage() {
    return ChatMessage(
      author: ChatMessageAuthor.assistant,
      text: _welcomeMessage,
      sentAt: DateTime.now(),
    );
  }

  Future<void> _sendMessage([
    String? retryPrompt,
    int? retryMessageIndex,
  ]) async {
    if (_isSending) return;

    final prompt = (retryPrompt ?? _messageController.text).trim();
    if (prompt.isEmpty) return;

    if (retryPrompt == null) {
      _messageController.clear();
    }

    final assistantIndex = retryMessageIndex ?? _messages.length + 1;

    setState(() {
      _isSending = true;
      if (retryMessageIndex != null) {
        _messages[retryMessageIndex] = ChatMessage(
          author: ChatMessageAuthor.assistant,
          text: '',
          sentAt: DateTime.now(),
          isLoading: true,
        );
      } else {
        _messages
          ..add(
            ChatMessage(
              author: ChatMessageAuthor.user,
              text: prompt,
              sentAt: DateTime.now(),
            ),
          )
          ..add(
            ChatMessage(
              author: ChatMessageAuthor.assistant,
              text: '',
              sentAt: DateTime.now(),
              isLoading: true,
            ),
          );
      }
    });

    _scrollToBottom();
    var fullResponse = '';

    try {
      await for (final chunk in _chatService.sendMessageStream(prompt)) {
        fullResponse += chunk;
        if (!mounted) return;

        setState(() {
          _messages[assistantIndex] = _messages[assistantIndex].copyWith(
            text: fullResponse,
          );
        });
        _scrollToBottom();
      }

      if (!mounted) return;
      setState(() {
        _messages[assistantIndex] = _messages[assistantIndex].copyWith(
          text: fullResponse.trim().isEmpty
              ? 'I was unable to generate a response.'
              : fullResponse,
          isLoading: false,
        );
      });
    } catch (error) {
      if (!mounted) return;
      final message = error is ChatServiceException
          ? error.userMessage
          : 'Something went wrong. Please try again.';

      setState(() {
        _messages[assistantIndex] = _messages[assistantIndex].copyWith(
          text: message,
          isLoading: false,
          isError: true,
          retryPrompt: prompt,
        );
      });
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
        _scrollToBottom();
      }
    }
  }

  void _startNewChat() {
    if (_isSending) return;

    _chatService.startNewChat();
    setState(() {
      _messages
        ..clear()
        ..add(_createWelcomeMessage());
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(onNewChat: _startNewChat),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final message = _messages[index];

                        return ChatBubble(
                          key: ValueKey(message),
                          message: message,
                          onRetry: message.retryPrompt == null
                              ? null
                              : () {
                                  _sendMessage(message.retryPrompt, index);
                                },
                        );
                      },
                      childCount: _messages.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SectionSendMessage(
            controller: _messageController,
            isSending: _isSending,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}
