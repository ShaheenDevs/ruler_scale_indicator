import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ruler_scale_indicator/ruler_scale_indicator.dart';

void main() {
  group('ScaleRuler Widget Tests', () {
    testWidgets('renders correctly with default parameters',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ScaleRuler(),
          ),
        ),
      );

      // Assert
      expect(find.byType(ScaleRuler), findsOneWidget);
      expect(find.text('0.0'), findsOneWidget); // Check initial display
    });

    testWidgets('updates position on horizontal drag',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ScaleRuler(),
          ),
        ),
      );

      // Act
      await tester.drag(find.byType(GestureDetector), const Offset(100, 0));
      await tester.pumpAndSettle();

      // Assert
      expect(find.textContaining(RegExp(r'^\d+\.\d$')), findsOneWidget);
    });

    testWidgets('displays correct decimal places', (WidgetTester tester) async {
      // Arrange
      const decimalPlaces = 2;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ScaleRuler(
              decimalPlaces: decimalPlaces,
            ),
          ),
        ),
      );

      // Act
      await tester.drag(find.byType(GestureDetector), const Offset(50, 0));
      await tester.pumpAndSettle();

      // Assert
      expect(
        find.textContaining(RegExp(r'^\d+\.\d{2}$')),
        findsOneWidget,
      ); // Matches the expected decimal places
    });

    testWidgets('handles custom range and line spacing',
        (WidgetTester tester) async {
      // Arrange
      const minRange = 0.0;
      const maxRange = 500.0;
      const lineSpacing = 20.0;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ScaleRuler(
              minRange: minRange,
              maxRange: maxRange,
              lineSpacing: lineSpacing,
            ),
          ),
        ),
      );

      // Act
      await tester.drag(find.byType(GestureDetector), const Offset(200, 0));
      await tester.pumpAndSettle();

      // Assert
      expect(find.textContaining(RegExp(r'^\d+\.\d$')), findsOneWidget);
    });
  });
}
