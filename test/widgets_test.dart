import 'package:baby_sitter/widgets/custom_widgets/icon_with_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('IconWithDescription shows description dialog on long press',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: IconWithDescription(icon: Icons.notification_add),
          ),
        ),
      ),
    );

    // Verify that the dialog is initially hidden
    expect(find.byType(AlertDialog), findsNothing);

    // Long press on the icon
    final gesture =
        await tester.startGesture(tester.getCenter(find.byType(Icon)));
    await tester.pump();

    // Wait for the dialog to be displayed
    await tester.pump(const Duration(milliseconds: 500));

    // Verify that the dialog is displayed
    expect(find.byType(AlertDialog), findsOneWidget);

    // End the long press
    await gesture.up();
    await tester.pump();

    // Wait for the dialog to be hidden
    await tester.pump(const Duration(milliseconds: 500));

    // Verify that the dialog is hidden again
    expect(find.byType(AlertDialog), findsNothing);
  });
}
