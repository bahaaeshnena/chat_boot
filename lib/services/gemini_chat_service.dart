import 'package:firebase_ai/firebase_ai.dart';

abstract interface class ChatService {
  bool get isSending;

  Future<String> sendMessage(String message);

  Stream<String> sendMessageStream(String message);

  void startNewChat();
}

class ChatServiceException implements Exception {
  const ChatServiceException(this.userMessage, [this.cause]);

  final String userMessage;
  final Object? cause;

  @override
  String toString() => userMessage;
}

class GeminiChatService implements ChatService {
  late final GenerativeModel _model;
  late ChatSession _chat;

  @override
  bool isSending = false;

  GeminiChatService() {
    _model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-3.7-flash',
      systemInstruction: Content.system(
        'You are Boot AI, a helpful assistant for learning and programming. '
        'Answer in the same language used by the user. Keep answers clear, '
        'accurate, and concise unless the user asks for more detail.',
      ),
    );

    startNewChat();
  }

  @override
  Future<String> sendMessage(String message) async {
    final prompt = _validateMessage(message);
    isSending = true;

    try {
      final response = await _chat.sendMessage(Content.text(prompt));
      return response.text ?? 'I was unable to generate a response.';
    } catch (error) {
      throw _mapError(error);
    } finally {
      isSending = false;
    }
  }

  @override
  Stream<String> sendMessageStream(String message) async* {
    final prompt = _validateMessage(message);
    isSending = true;

    try {
      final response = _chat.sendMessageStream(Content.text(prompt));

      await for (final chunk in response) {
        final text = chunk.text;
        if (text != null && text.isNotEmpty) {
          yield text;
        }
      }
    } catch (error) {
      throw _mapError(error);
    } finally {
      isSending = false;
    }
  }

  @override
  void startNewChat() {
    if (isSending) {
      throw const ChatServiceException(
        'Wait for the current response before starting a new chat.',
      );
    }

    _chat = _model.startChat();
  }

  String _validateMessage(String message) {
    final prompt = message.trim();

    if (prompt.isEmpty) {
      throw const ChatServiceException('Please enter a message first.');
    }

    if (isSending) {
      throw const ChatServiceException('Wait for the current response.');
    }

    return prompt;
  }

  ChatServiceException _mapError(Object error) {
    if (error is ChatServiceException) {
      return error;
    }

    if (error is QuotaExceeded) {
      return ChatServiceException(
        'The Gemini usage limit has been reached. Wait a moment and try again.',
        error,
      );
    }

    if (error is ServiceApiNotEnabled) {
      return ChatServiceException(
        'Firebase AI Logic is not enabled for this project.',
        error,
      );
    }

    if (error is UnsupportedUserLocation) {
      return ChatServiceException(
        'Gemini is not available in your current location.',
        error,
      );
    }

    if (error is FirebaseAIException) {
      return ChatServiceException(
        'Gemini could not generate a response. Please try again.',
        error,
      );
    }

    return ChatServiceException(
      'Could not connect to the service. Check your internet and try again.',
      error,
    );
  }
}
