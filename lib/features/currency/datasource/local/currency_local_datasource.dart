import '../../../../core/database/app_database.dart';
import '../../models/currency_model.dart';

class CurrencyLocalDatasource {
  final AppDatabase database;

  CurrencyLocalDatasource(this.database);

  Future<void> saveCurrencies(List<CurrencyModel> currencies) async {
    await database.batch((batch) {
      batch.insertAll(
        database.currencyTable,
        currencies.map((currency) {
          return CurrencyTableCompanion.insert(
            code: currency.code,
            rate: currency.rate,
            updatedAt: currency.updatedAt,
          );
        }).toList(),
      );
    });
  }

  Future<List<CurrencyModel>> getCurrencies() async {
    final result = await database.select(database.currencyTable).get();

    return result.map((item) {
      return CurrencyModel(
        code: item.code,
        rate: item.rate,
        updatedAt: item.updatedAt,
      );
    }).toList();
  }
}
