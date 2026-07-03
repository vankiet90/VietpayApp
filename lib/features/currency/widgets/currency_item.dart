import 'package:flutter/material.dart';

import '../models/currency_model.dart';

class CurrencyItem extends StatelessWidget {
  final CurrencyModel currency;

  const CurrencyItem({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(currency.code),
      leading: CircleAvatar(child: Text(currency.code.substring(0, 1))),
      title: Text(
        currency.code,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing: Text(
        currency.rate.toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
