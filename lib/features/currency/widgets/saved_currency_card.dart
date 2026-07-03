import 'package:flutter/material.dart';

import '../models/currency_model.dart';

class SavedCurrencyCard extends StatelessWidget {
  final List<CurrencyModel> currencies;

  const SavedCurrencyCard({super.key, required this.currencies});

  @override
  Widget build(BuildContext context) {
    final jpy = currencies.firstWhere(
      (e) => e.code == "JPY",
      orElse: () => currencies.first,
    );

    // CurrencyFreaks return base = USD
    // jpy.rate =  JPY for 1 USD
    // => 1 JPY = 1 / rate USD
    final usdRate = 1 / jpy.rate;

    return Card(
      key: const Key("saved_currency_card"),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Saved Currency",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Icon(
                  Icons.bookmark,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),

                const SizedBox(width: 12),

                Text(
                  jpy.code,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                const Icon(Icons.arrow_forward),

                const SizedBox(width: 8),

                const Text(
                  "USD",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              "1 ${jpy.code} = ${usdRate.toStringAsFixed(6)} USD",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
