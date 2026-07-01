import 'package:flutter/material.dart';
import '../../../core/di/service_locator.dart';
import '../repository/currency_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _testApi();
  }

  Future<void> _testApi() async {
    final repository = sl<CurrencyRepository>();

    final response = await repository.fetchLatestRates();

    debugPrint("Base: ${response.base}");
    debugPrint("Date: ${response.date}");
    debugPrint("Total rates: ${response.rates.length}");
    debugPrint("USD -> VND: ${response.rates['VND']}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Currency Converter")),
      body: const Center(child: Text("Sprint 2")),
    );
  }
}
