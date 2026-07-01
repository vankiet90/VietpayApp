import '../datasource/remote/currency_remote_datasource.dart';
import '../models/currency_response.dart';

class CurrencyRepository {
  final CurrencyRemoteDatasource remote;

  CurrencyRepository(this.remote);

  Future<CurrencyResponse> fetchLatestRates() {
    return remote.fetchLatestRates();
  }
}
