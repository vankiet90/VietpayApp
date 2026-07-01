import 'package:dio/dio.dart';
import 'package:vietpay_app/core/config/app_config.dart';

import '../../models/currency_response.dart';

class CurrencyRemoteDatasource {
  final Dio dio;

  CurrencyRemoteDatasource(this.dio);

  Future<CurrencyResponse> fetchLatestRates() async {
    final response = await dio.get(
      "/rates/latest",

      queryParameters: {"apikey": AppConfig.apiKey},
    );

    return CurrencyResponse.fromJson(response.data);
  }
}
