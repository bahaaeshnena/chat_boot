enum ChatMessageAuthor { user, assistant }

class ChatMessage {
  const ChatMessage({
    required this.author,
    required this.text,
    required this.sentAt,
    this.isLoading = false,
    this.isError = false,
    this.retryPrompt,
  });

  final ChatMessageAuthor author;
  final String text;
  final DateTime sentAt;
  final bool isLoading;
  final bool isError;
  final String? retryPrompt;

  bool get isFromUser => author == ChatMessageAuthor.user;

  ChatMessage copyWith({
    String? text,
    bool? isLoading,
    bool? isError,
    String? retryPrompt,
  }) {
    return ChatMessage(
      author: author,
      text: text ?? this.text,
      sentAt: sentAt,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      retryPrompt: retryPrompt ?? this.retryPrompt,
    );
  }
}
