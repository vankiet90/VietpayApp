import 'currency_model.dart';

class CurrencyResult {
  final List<CurrencyModel> currencies;

  /// true = read from Drift
  /// false = read from API
  final bool isFromCache;

  final DateTime updatedAt;

  const CurrencyResult({
    required this.currencies,
    required this.isFromCache,
    required this.updatedAt,
  });
}
