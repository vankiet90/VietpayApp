import '../datasource/local/currency_local_datasource.dart';
import '../datasource/remote/currency_remote_datasource.dart';
import '../mapper/currency_mapper.dart';
import '../models/currency_result.dart';
import 'currency_repository.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDatasource remote;
  final CurrencyLocalDatasource local;

  CurrencyRepositoryImpl(this.remote, this.local);

  @override
  Future<CurrencyResult> fetchLatestRates() async {
    try {
      final response = await remote.fetchLatestRates();

      final currencies = CurrencyMapper.fromResponse(response);

      await local.saveCurrencies(currencies);

      return CurrencyResult(
        currencies: currencies,
        isFromCache: false,
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      final cached = await local.getCurrencies();

      return CurrencyResult(
        currencies: cached,
        isFromCache: true,
        updatedAt: cached.first.updatedAt,
      );
    }
  }
}
