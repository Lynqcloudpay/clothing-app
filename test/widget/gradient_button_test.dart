import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:threadsense/core/widgets/gradient_button.dart';

void main() {
  testWidgets('GradientButton displays correct label and responds to tap',
      (WidgetTester tester) async {
    bool wasTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GradientButton(
            label: 'Test Button',
            onPressed: () => wasTapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);
    await tester.tap(find.byType(GradientButton));
    expect(wasTapped, true);
  });
}
