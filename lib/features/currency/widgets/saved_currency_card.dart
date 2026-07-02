import 'package:flutter/material.dart';

class SavedCurrencyCard extends StatelessWidget {
  final Map<String, double> rates;

  const SavedCurrencyCard({super.key, required this.rates});

  @override
  Widget build(BuildContext context) {
    const savedCurrency = "JPY";

    final rate = rates[savedCurrency] ?? 0;

    final usd = rate == 0 ? 0 : 1 / rate;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Saved Currency",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  savedCurrency,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward),
                const SizedBox(width: 8),
                const Text(
                  "USD",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "1 $savedCurrency = ${usd.toStringAsFixed(6)} USD",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
