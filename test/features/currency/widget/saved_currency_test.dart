import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vietpay_app/features/currency/models/currency_model.dart';
import 'package:vietpay_app/features/currency/widgets/saved_currency_card.dart';

void main() {
  final currencies = [
    CurrencyModel(code: "USD", rate: 1, updatedAt: DateTime.now()),
    CurrencyModel(code: "JPY", rate: 147, updatedAt: DateTime.now()),
    CurrencyModel(code: "VND", rate: 26000, updatedAt: DateTime.now()),
  ];

  Widget createWidget() {
    return MaterialApp(
      home: Scaffold(body: SavedCurrencyCard(currencies: currencies)),
    );
  }

  group("SavedCurrencyCard", () {
    testWidgets("Should render card", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("saved_currency_card")), findsOneWidget);
    });

    testWidgets("Should show title", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("saved_currency_title")), findsOneWidget);
    });

    testWidgets("Should show JPY", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("saved_currency_code")), findsOneWidget);
    });

    testWidgets("Should show USD target", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("saved_currency_target")), findsOneWidget);
    });

    testWidgets("Should display conversion rate", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("saved_currency_rate")), findsOneWidget);
    });
  });
}
