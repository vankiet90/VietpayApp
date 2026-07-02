import 'package:flutter/material.dart';

import '../models/currency_model.dart';
import 'currency_item.dart';

class CurrencyList extends StatelessWidget {
  final List<CurrencyModel> currencies;

  const CurrencyList({super.key, required this.currencies});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: currencies.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return CurrencyItem(currency: currencies[index]);
      },
    );
  }
}
