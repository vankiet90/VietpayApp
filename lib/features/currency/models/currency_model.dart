class CurrencyModel {
  final String code;
  final double rate;
  final DateTime updatedAt;

  const CurrencyModel({
    required this.code,
    required this.rate,
    required this.updatedAt,
  });
}
