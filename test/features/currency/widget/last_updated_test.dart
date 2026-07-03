import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vietpay_app/features/currency/widgets/last_updated_widget.dart';

void main() {
  final updatedAt = DateTime(2026, 7, 12, 21, 30);

  Widget createWidget() {
    return MaterialApp(
      home: Scaffold(body: LastUpdatedWidget(updatedAt: updatedAt)),
    );
  }

  group("LastUpdatedWidget", () {
    testWidgets("Should render widget", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("last_updated")), findsOneWidget);
    });

    testWidgets("Should show Last Updated label", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.textContaining("Last Updated"), findsOneWidget);
    });

    testWidgets("Should display formatted date", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.textContaining("12/07/2026"), findsOneWidget);
    });
  });
}
