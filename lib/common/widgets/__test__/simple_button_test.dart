import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/common/widgets/card_widget.dart';

void main() {
  testWidgets('Simple button test ', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    const key = ValueKey('key_button');
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            child: CardWidget(
              key: key,
              text: 'hi',
              height: 100,
              width: 100,
              borderRadius: 0,
              bgColors: [Colors.red, Colors.red],
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.byKey(key), findsOneWidget);

    await tester.tap(find.byKey(key));
    await tester.pump();
  });
}
