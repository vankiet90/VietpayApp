import '../models/currency_result.dart';

abstract class CurrencyRepository {
  Future<CurrencyResult> fetchLatestRates();
}
