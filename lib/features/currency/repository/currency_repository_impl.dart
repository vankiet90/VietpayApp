import '../datasource/remote/currency_remote_datasource.dart';
import '../models/currency_response.dart';
import 'currency_repository.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDatasource remote;

  CurrencyRepositoryImpl(this.remote);

  @override
  Future<CurrencyResponse> fetchLatestRates() {
    return remote.fetchLatestRates();
  }
}
