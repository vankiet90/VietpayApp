import 'package:flutter/material.dart';
import 'package:vietpay_app/core/constants/app_constants.dart';
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
    _loadCurrencyRates();
  }

  Future<void> _loadCurrencyRates() async {
    try {
      final repository = sl<CurrencyRepository>();

      final result = await repository.fetchLatestRates();

      debugPrint("========== RESULT ==========");

      debugPrint("Total currencies: ${result.currencies.length}");
      debugPrint("From cache: ${result.isFromCache}");
      debugPrint("Updated at: ${result.updatedAt}");

      if (result.currencies.isNotEmpty) {
        debugPrint(
          "First currency: ${result.currencies.first.code} - ${result.currencies.first.rate}",
        );
      }

      debugPrint("============================");
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appName)),
      body: const Center(
        child: Text("Welcome to VietpayApp's currency converter app."),
      ),
    );
  }
}
