import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vietpay_app/features/currency/models/currency_model.dart';
import 'package:vietpay_app/features/currency/widgets/converter_section.dart';

void main() {
  late List<CurrencyModel> currencies;

  setUp(() {
    currencies = [
      CurrencyModel(code: "USD", rate: 1, updatedAt: DateTime.now()),
      CurrencyModel(code: "JPY", rate: 150, updatedAt: DateTime.now()),
      CurrencyModel(code: "VND", rate: 26000, updatedAt: DateTime.now()),
    ];
  });

  Widget createWidget() {
    return MaterialApp(
      home: Scaffold(body: ConverterSection(currencies: currencies)),
    );
  }

  group("ConverterSection Render", () {
    testWidgets("Should render converter title", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text("Currency Converter"), findsOneWidget);
    });

    testWidgets("Should render amount input", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("amount_input")), findsOneWidget);
    });

    testWidgets("Should render from dropdown", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("from_currency")), findsOneWidget);
    });

    testWidgets("Should render to dropdown", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("to_currency")), findsOneWidget);
    });

    testWidgets("Should render swap button", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("swap_button")), findsOneWidget);
    });

    testWidgets("Should render converted result", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("converted_result")), findsOneWidget);
    });

    testWidgets("Should render converted amount", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("converted_amount")), findsOneWidget);
    });

    testWidgets("Should render converted currency", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("converted_currency")), findsOneWidget);
    });

    testWidgets("Default amount should be 100", (tester) async {
      await tester.pumpWidget(createWidget());

      final textField = tester.widget<TextField>(
        find.byKey(const Key("amount_input")),
      );

      expect(textField.controller!.text, "100");
    });

    testWidgets("Default converted currency should be VND", (tester) async {
      await tester.pumpWidget(createWidget());

      final currency = tester.widget<Text>(
        find.byKey(const Key("converted_currency")),
      );

      expect(currency.data, "VND");
    });
  });

  group("ConverterSection Interaction", () {
    testWidgets("Should change amount", (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byKey(const Key("amount_input")), "200");

      await tester.pump();

      final textField = tester.widget<TextField>(
        find.byKey(const Key("amount_input")),
      );

      expect(textField.controller!.text, "200");
    });

    testWidgets("Should accept decimal input", (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byKey(const Key("amount_input")), "99.99");

      await tester.pump();

      final textField = tester.widget<TextField>(
        find.byKey(const Key("amount_input")),
      );

      expect(textField.controller!.text, "99.99");
    });

    testWidgets("Should clear amount", (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byKey(const Key("amount_input")), "");

      await tester.pump();

      final textField = tester.widget<TextField>(
        find.byKey(const Key("amount_input")),
      );

      expect(textField.controller!.text, "");
    });

    testWidgets("Should handle invalid input", (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byKey(const Key("amount_input")), "abc");

      await tester.pump();

      expect(find.byKey(const Key("converted_amount")), findsOneWidget);
    });

    testWidgets("Should convert zero amount", (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byKey(const Key("amount_input")), "0");

      await tester.pump();

      final amount = tester.widget<Text>(
        find.byKey(const Key("converted_amount")),
      );

      expect(amount.data, "0");
    });

    testWidgets("Should support large number", (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(
        find.byKey(const Key("amount_input")),
        "999999999",
      );

      await tester.pump();

      expect(find.byKey(const Key("converted_amount")), findsOneWidget);
    });

    testWidgets("Swap should exchange currencies", (tester) async {
      await tester.pumpWidget(createWidget());

      final before = tester.widget<Text>(
        find.byKey(const Key("converted_currency")),
      );

      await tester.tap(find.byKey(const Key("swap_button")));

      await tester.pumpAndSettle();

      final after = tester.widget<Text>(
        find.byKey(const Key("converted_currency")),
      );

      expect(after.data, isNot(equals(before.data)));
    });

    testWidgets("Swap twice should return original currency", (tester) async {
      await tester.pumpWidget(createWidget());

      final before = tester.widget<Text>(
        find.byKey(const Key("converted_currency")),
      );

      await tester.tap(find.byKey(const Key("swap_button")));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("swap_button")));
      await tester.pumpAndSettle();

      final after = tester.widget<Text>(
        find.byKey(const Key("converted_currency")),
      );

      expect(after.data, before.data);
    });

    testWidgets("Converted amount should update after input", (tester) async {
      await tester.pumpWidget(createWidget());

      final before = tester.widget<Text>(
        find.byKey(const Key("converted_amount")),
      );

      await tester.enterText(find.byKey(const Key("amount_input")), "300");

      await tester.pump();

      final after = tester.widget<Text>(
        find.byKey(const Key("converted_amount")),
      );

      expect(after.data, isNot(equals(before.data)));
    });

    testWidgets("Converter should remain visible after interaction", (
      tester,
    ) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byKey(const Key("amount_input")), "500");

      await tester.tap(find.byKey(const Key("swap_button")));

      await tester.pumpAndSettle();

      expect(find.byKey(const Key("converted_result")), findsOneWidget);

      expect(find.byKey(const Key("converted_amount")), findsOneWidget);
    });
  });
}
