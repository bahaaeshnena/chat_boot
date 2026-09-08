import 'package:chat_boot/main.dart';
import 'package:chat_boot/services/gemini_chat_service.dart';
import 'package:chat_boot/utils/widgets/custom_text_field.dart';
import 'package:chat_boot/views/chat/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('moves through all onboarding pages', (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 932));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MyApp());

    expect(find.text('Welcome to Boot AI'), findsOneWidget);
    expect(
      find.text(
        'Your intelligent assistant for learning, coding and creating.',
      ),
      findsOneWidget,
    );
    expect(find.text('Get Started'), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Smart Conversations'), findsOneWidget);
    expect(
      find.text('Ask anything and get helpful answers powered by Gemini.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Built for Developers'), findsOneWidget);
    expect(
      find.text('Write, debug, explore and build faster with AI by your side'),
      findsOneWidget,
    );
    expect(find.text('Let’s Go'), findsOneWidget);
  });

  testWidgets('renders the chat design', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: ChatView(chatService: _FakeChatService())),
    );

    expect(find.text('Boot AI'), findsWidgets);
    expect(find.text('Hello, how can I assist you today?'), findsOneWidget);
    expect(find.text('Ask me anything...'), findsOneWidget);
    expect(find.byType(CustomTextField), findsOneWidget);
    expect(find.byIcon(Icons.send_rounded), findsOneWidget);
  });

  testWidgets('sends the typed message and displays the streamed reply', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: ChatView(chatService: _FakeChatService())),
    );

    await tester.enterText(find.byType(TextFormField), 'What is Flutter?');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();

    expect(find.text('What is Flutter?'), findsOneWidget);
    expect(find.text('Flutter is a UI toolkit.'), findsOneWidget);
  });
}

class _FakeChatService implements ChatService {
  @override
  bool isSending = false;

  @override
  Future<String> sendMessage(String message) async {
    return 'Flutter is a UI toolkit.';
  }

  @override
  Stream<String> sendMessageStream(String message) async* {
    isSending = true;
    try {
      yield 'Flutter is ';
      yield 'a UI toolkit.';
    } finally {
      isSending = false;
    }
  }

  @override
  void startNewChat() {}
}
