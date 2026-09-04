import 'package:chat_boot/main.dart';
import 'package:chat_boot/utils/widgets/custom_text_field.dart';
import 'package:chat_boot/views/chat/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('moves through all onboarding pages', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Welcome to Boot AI'), findsOneWidget);
    expect(
      find.text(
        'Your intelligent assistant for learning, coding and creating.',
      ),
      findsOneWidget,
    );
    expect(find.text('Next'), findsOneWidget);

    await tester.tap(find.text('Next'));
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
    await tester.pumpWidget(const MaterialApp(home: ChatView()));

    expect(find.text('Boot AI'), findsWidgets);
    expect(find.text('What is Flutter?'), findsOneWidget);
    expect(find.text('Ask anything...'), findsOneWidget);
    expect(find.byType(CustomTextField), findsOneWidget);
    expect(find.byIcon(Icons.send_rounded), findsOneWidget);
  });
}
