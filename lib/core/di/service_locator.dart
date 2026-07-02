import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/currency/bloc/currency_bloc.dart';
import '../../features/currency/datasource/local/currency_local_datasource.dart';
import '../api/dio_client.dart';
import '../../features/currency/datasource/remote/currency_remote_datasource.dart';
import '../../features/currency/repository/currency_repository.dart';
import '../../features/currency/repository/currency_repository_impl.dart';
import '../database/app_database.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  final dioClient = DioClient();

  sl.registerLazySingleton<Dio>(() => dioClient.dio);

  sl.registerLazySingleton<AppDatabase>(AppDatabase.new);

  sl.registerLazySingleton<CurrencyLocalDatasource>(
    () => CurrencyLocalDatasource(sl()),
  );
  sl.registerLazySingleton<CurrencyRemoteDatasource>(
    () => CurrencyRemoteDatasource(sl()),
  );

  sl.registerLazySingleton<CurrencyRepository>(
    () => CurrencyRepositoryImpl(sl(), sl()),
  );

  sl.registerFactory(() => CurrencyBloc(sl()));
}
