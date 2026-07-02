import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../api/dio_client.dart';
import '../../features/currency/datasource/remote/currency_remote_datasource.dart';
import '../../features/currency/repository/currency_repository.dart';
import '../../features/currency/repository/currency_repository_impl.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  final dioClient = DioClient();

  sl.registerLazySingleton<Dio>(() => dioClient.dio);

  sl.registerLazySingleton<CurrencyRemoteDatasource>(
    () => CurrencyRemoteDatasource(sl()),
  );

  sl.registerLazySingleton<CurrencyRepository>(
    () => CurrencyRepositoryImpl(sl()),
  );
}
