import '../models/currency_model.dart';
import '../models/currency_response.dart';

class CurrencyMapper {
  static List<CurrencyModel> fromResponse(CurrencyResponse response) {
    return response.rates.entries.map((entry) {
      return CurrencyModel(
        code: entry.key,
        rate: double.parse(entry.value.toString()),
        updatedAt: DateTime.now(),
      );
    }).toList();
  }
}
