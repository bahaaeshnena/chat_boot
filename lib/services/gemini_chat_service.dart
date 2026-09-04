import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';

class GeminiChatService {
  static final GeminiChatService _testService = GeminiChatService();

  late final ChatSession _chat;

  bool isSending = false;

  GeminiChatService() {
    final model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-3.7-flash',
      systemInstruction: Content.system(
        'You are a helpful assistant that provides concise '
        'and accurate answers to user queries.',
      ),
    );

    _chat = model.startChat();
  }

  Future<String> sendMessage(String message) async {
    if (isSending) {
      return 'يرجى انتظار اكتمال الرد الحالي.';
    }

    isSending = true;

    try {
      final response = await _chat.sendMessage(
        Content.text(message),
      );

      return response.text ?? 'لم أتمكن من إنشاء إجابة.';
    } finally {
      isSending = false;
    }
  }

  Stream<String> sendMessageStream(String message) async* {
    if (isSending) {
      yield 'يرجى انتظار اكتمال الرد الحالي.';
      return;
    }

    isSending = true;

    try {
      final response = _chat.sendMessageStream(
        Content.text(message),
      );

      await for (final chunk in response) {
        final text = chunk.text;

        if (text != null) {
          yield text;
        }
      }
    } finally {
      isSending = false;
    }
  }

  static Future<void> testGemini() async {
    if (_testService.isSending) {
      debugPrint('يوجد طلب قيد التنفيذ، انتظر قليلًا.');
      return;
    }

    try {
      final response = await _testService.sendMessage(
        'اشرح لي Flutter بجملة واحدة',
      );

      debugPrint('Gemini response: $response');
    } catch (error) {
      debugPrint('Gemini error: $error');
    }
  }
}
