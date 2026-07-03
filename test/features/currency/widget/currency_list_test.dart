import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vietpay_app/features/currency/models/currency_model.dart';
import 'package:vietpay_app/features/currency/widgets/currency_item.dart';
import 'package:vietpay_app/features/currency/widgets/currency_list.dart';

void main() {
  late List<CurrencyModel> currencies;

  setUp(() {
    currencies = [
      CurrencyModel(code: "USD", rate: 1, updatedAt: DateTime.now()),
      CurrencyModel(code: "JPY", rate: 147, updatedAt: DateTime.now()),
      CurrencyModel(code: "VND", rate: 26000, updatedAt: DateTime.now()),
    ];
  });

  Widget createWidget() {
    return MaterialApp(
      home: Scaffold(body: CurrencyList(currencies: currencies)),
    );
  }

  group("CurrencyList Widget", () {
    testWidgets("Should render ListView", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets("Should render 3 currency items", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(CurrencyItem), findsNWidgets(3));
    });

    testWidgets("Should display USD item", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("currency_USD")), findsOneWidget);

      expect(find.byKey(const Key("currency_code_USD")), findsOneWidget);

      expect(find.byKey(const Key("currency_rate_USD")), findsOneWidget);
    });

    testWidgets("Should display JPY item", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("currency_JPY")), findsOneWidget);

      expect(find.byKey(const Key("currency_code_JPY")), findsOneWidget);

      expect(find.byKey(const Key("currency_rate_JPY")), findsOneWidget);
    });

    testWidgets("Should display VND item", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("currency_VND")), findsOneWidget);

      expect(find.byKey(const Key("currency_code_VND")), findsOneWidget);

      expect(find.byKey(const Key("currency_rate_VND")), findsOneWidget);
    });

    testWidgets("Should display correct currency codes", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text("USD"), findsOneWidget);
      expect(find.text("JPY"), findsOneWidget);
      expect(find.text("VND"), findsOneWidget);
    });

    testWidgets("Should display correct rates", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text("1.0"), findsOneWidget);
      expect(find.text("147.0"), findsOneWidget);
      expect(find.text("26000.0"), findsOneWidget);
    });

    testWidgets("Should render avatar for every currency", (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byKey(const Key("currency_avatar_USD")), findsOneWidget);

      expect(find.byKey(const Key("currency_avatar_JPY")), findsOneWidget);

      expect(find.byKey(const Key("currency_avatar_VND")), findsOneWidget);
    });
  });
}
