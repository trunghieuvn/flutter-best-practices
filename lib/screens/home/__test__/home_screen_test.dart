import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../home_screen.dart';

void main() {
  testWidgets('Home screen test ', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  });
}
