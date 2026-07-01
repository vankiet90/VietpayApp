class CurrencyResponse {
  final String base;

  final String date;

  final Map<String, dynamic> rates;

  CurrencyResponse({
    required this.base,

    required this.date,

    required this.rates,
  });

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) {
    return CurrencyResponse(
      base: json['base'],

      date: json['date'],

      rates: json['rates'],
    );
  }
}
