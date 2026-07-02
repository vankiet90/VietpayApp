import 'package:flutter/material.dart';

class ConverterSection extends StatefulWidget {
  final Map<String, double> rates;

  const ConverterSection({super.key, required this.rates});

  @override
  State<ConverterSection> createState() => _ConverterSectionState();
}

class _ConverterSectionState extends State<ConverterSection> {
  final controller = TextEditingController(text: "100");

  String from = "USD";

  String to = "VND";

  double result = 0;

  @override
  void initState() {
    super.initState();

    _convert();
  }

  void _convert() {
    final amount = double.tryParse(controller.text) ?? 0;

    final fromRate = widget.rates[from] ?? 1;

    final toRate = widget.rates[to] ?? 1;

    final usd = amount / fromRate;

    result = usd * toRate;
  }

  @override
  Widget build(BuildContext context) {
    final currencies = widget.rates.keys.toList();

    return Card(
      margin: const EdgeInsets.all(16),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: controller,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: "Amount"),

              onChanged: (_) {
                setState(() {
                  _convert();
                });
              },
            ),

            const SizedBox(height: 20),

            DropdownButton<String>(
              value: from,

              isExpanded: true,

              items: currencies.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),

              onChanged: (value) {
                setState(() {
                  from = value!;

                  _convert();
                });
              },
            ),

            const SizedBox(height: 12),

            DropdownButton<String>(
              value: to,

              isExpanded: true,

              items: currencies.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),

              onChanged: (value) {
                setState(() {
                  to = value!;

                  _convert();
                });
              },
            ),

            const SizedBox(height: 20),

            Text(
              result.toStringAsFixed(2),

              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
