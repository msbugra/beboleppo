import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:baby_tracker/main.dart';

void main() {
  testWidgets('Baby Tracker app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the splash screen is displayed
    expect(find.text('Baby Tracker'), findsOneWidget);
    expect(find.byIcon(Icons.child_care), findsOneWidget);
  });

  group('Age Calculator Tests', () {
    // Add age calculation tests here
    test('Calculate age in days', () {
      // Test implementation
    });
  });

  group('Validators Tests', () {
    // Add validation tests here
    test('Name validation', () {
      // Test implementation
    });
  });

  group('Percentile Calculator Tests', () {
    // Add percentile calculation tests here
    test('Weight percentile calculation', () {
      // Test implementation
    });
  });
}