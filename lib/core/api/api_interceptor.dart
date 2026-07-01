import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiInterceptor extends Interceptor {
  final Logger _logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final query = Map<String, dynamic>.from(options.queryParameters);

    if (query.containsKey('apikey')) {
      query['apikey'] = '******';
    }

    _logger.i('''
========== REQUEST ==========
${options.method}
${options.uri.replace(queryParameters: query)}

Headers:
${options.headers}
=============================
''');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('''
========== RESPONSE ==========
Status Code : ${response.statusCode}
Path        : ${response.requestOptions.path}
==============================
''');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('''
========== ERROR ==========
${err.requestOptions.path}

${err.message}
===========================
''');

    handler.next(err);
  }
}
