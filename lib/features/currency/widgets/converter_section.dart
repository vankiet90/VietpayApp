import 'package:flutter/material.dart';

import '../models/currency_model.dart';
import 'package:intl/intl.dart';

class ConverterSection extends StatefulWidget {
  final List<CurrencyModel> currencies;

  const ConverterSection({super.key, required this.currencies});

  @override
  State<ConverterSection> createState() => _ConverterSectionState();
}

class _ConverterSectionState extends State<ConverterSection> {
  final TextEditingController amountController = TextEditingController(
    text: "100",
  );

  double _convertedAmount = 0;

  late final NumberFormat _formatter;

  late CurrencyModel fromCurrency;

  late CurrencyModel toCurrency;

  @override
  void initState() {
    super.initState();

    fromCurrency = widget.currencies.first;

    toCurrency = widget.currencies.firstWhere(
      (e) => e.code == "VND",
      orElse: () => widget.currencies[1],
    );

    _formatter = NumberFormat("#,##0.######");

    amountController.addListener(_convert);

    _convert();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void _convert() {
    final amount = double.tryParse(amountController.text) ?? 0;

    if (amount <= 0) {
      setState(() {
        _convertedAmount = 0;
      });
      return;
    }

    final usdAmount = amount / fromCurrency.rate;

    final result = usdAmount * toCurrency.rate;

    setState(() {
      _convertedAmount = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Currency Converter",

              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 20),

            TextField(
              key: const Key("amount_input"),
              controller: amountController,

              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: const InputDecoration(
                labelText: "Amount",

                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<CurrencyModel>(
                    key: const Key("from_currency"),
                    value: fromCurrency,

                    decoration: const InputDecoration(
                      labelText: "From",

                      border: OutlineInputBorder(),
                    ),

                    items: widget.currencies
                        .map(
                          (currency) => DropdownMenuItem(
                            key: Key("from_${currency.code}"),
                            value: currency,

                            child: Text(currency.code),
                          ),
                        )
                        .toList(),

                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        fromCurrency = value;

                        _convert();
                      });
                    },
                  ),
                ),

                const SizedBox(width: 12),

                IconButton(
                  key: const Key("swap_button"),
                  onPressed: () {
                    setState(() {
                      final temp = fromCurrency;

                      fromCurrency = toCurrency;

                      toCurrency = temp;

                      _convert();
                    });
                  },

                  icon: const Icon(Icons.swap_horiz),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: DropdownButtonFormField<CurrencyModel>(
                    key: const Key("to_currency"),
                    value: toCurrency,

                    decoration: const InputDecoration(
                      labelText: "To",

                      border: OutlineInputBorder(),
                    ),

                    items: widget.currencies
                        .map(
                          (currency) => DropdownMenuItem(
                            key: Key("to_${currency.code}"),
                            value: currency,

                            child: Text(currency.code),
                          ),
                        )
                        .toList(),

                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        toCurrency = value;

                        _convert();
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Divider(),

            const SizedBox(height: 12),

            Text(
              "Converted Amount",

              style: Theme.of(context).textTheme.titleSmall,
            ),

            const SizedBox(height: 10),

            Text(
              "${amountController.text} ${fromCurrency.code}",
              key: const Key("input_summary"),
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 12),

            Container(
              key: const Key("converted_result"),
              width: double.infinity,

              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,

                borderRadius: BorderRadius.circular(12),
              ),

              child: Center(
                child: Column(
                  children: [
                    Text(
                      _formatter.format(_convertedAmount),
                      key: const Key("converted_amount"),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      toCurrency.code,
                      key: const Key("converted_currency"),
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
