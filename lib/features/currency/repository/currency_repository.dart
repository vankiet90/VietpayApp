import '../models/currency_response.dart';

abstract class CurrencyRepository {
  Future<CurrencyResponse> fetchLatestRates();
}
