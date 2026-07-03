import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vietpay_app/features/currency/widgets/offline_banner.dart';

void main() {
  Widget createWidget() {
    return const MaterialApp(home: Scaffold(body: OfflineBanner()));
  }

  group("OfflineBanner Widget", () {
    testWidgets("Should render OfflineBanner", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("offline_banner")), findsOneWidget);
    });

    testWidgets("Should display cached data message", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text("Using Cached Data"), findsOneWidget);
    });

    testWidgets("Should render exactly one Text widget", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
