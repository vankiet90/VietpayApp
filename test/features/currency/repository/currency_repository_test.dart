import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:vietpay_app/features/currency/datasource/local/currency_local_datasource.dart';
import 'package:vietpay_app/features/currency/datasource/remote/currency_remote_datasource.dart';

import 'package:vietpay_app/features/currency/models/currency_model.dart';
import 'package:vietpay_app/features/currency/models/currency_response.dart';

import 'package:vietpay_app/features/currency/repository/currency_repository_impl.dart';

class MockRemote extends Mock implements CurrencyRemoteDatasource {}

class MockLocal extends Mock implements CurrencyLocalDatasource {}

void main() {
  late MockRemote remote;
  late MockLocal local;
  late CurrencyRepositoryImpl repository;

  setUp(() {
    remote = MockRemote();
    local = MockLocal();

    repository = CurrencyRepositoryImpl(remote, local);
  });

  final response = CurrencyResponse(
    base: "USD",
    date: "2026-07-12",
    rates: {"USD": 1, "VND": 26000, "JPY": 147},
  );

  final cache = [
    CurrencyModel(code: "USD", rate: 1, updatedAt: DateTime(2026)),
    CurrencyModel(code: "VND", rate: 26000, updatedAt: DateTime(2026)),
  ];

  //-----------------------------------------------------
  //1
  //-----------------------------------------------------

  test("API success returns remote data", () async {
    when(() => remote.fetchLatestRates()).thenAnswer((_) async => response);

    when(() => local.saveCurrencies(any())).thenAnswer((_) async {});

    final result = await repository.fetchLatestRates();

    expect(result.isFromCache, false);

    expect(result.currencies.length, 3);
  });

  //-----------------------------------------------------
  //2
  //-----------------------------------------------------

  test("Save cache after API success", () async {
    when(() => remote.fetchLatestRates()).thenAnswer((_) async => response);

    when(() => local.saveCurrencies(any())).thenAnswer((_) async {});

    await repository.fetchLatestRates();

    verify(() => local.saveCurrencies(any())).called(1);
  });

  //-----------------------------------------------------
  //3
  //-----------------------------------------------------

  test("Load cache when API failed", () async {
    when(() => remote.fetchLatestRates()).thenThrow(
      DioException(requestOptions: RequestOptions(path: '/rates/latest')),
    );

    when(() => local.getCurrencies()).thenAnswer((_) async => cache);

    final result = await repository.fetchLatestRates();

    expect(result.isFromCache, true);

    expect(result.currencies.length, 2);
  });

  //-----------------------------------------------------
  //4
  //-----------------------------------------------------

  test("Throw exception when cache is empty", () async {
    when(() => remote.fetchLatestRates()).thenThrow(
      DioException(requestOptions: RequestOptions(path: "/rates/latest")),
    );

    when(() => local.getCurrencies()).thenAnswer((_) async => []);

    expect(repository.fetchLatestRates(), throwsException);
  });

  //-----------------------------------------------------
  //5
  //-----------------------------------------------------

  test("Currency mapper maps correctly", () async {
    when(() => remote.fetchLatestRates()).thenAnswer((_) async => response);

    when(() => local.saveCurrencies(any())).thenAnswer((_) async {});

    final result = await repository.fetchLatestRates();

    expect(result.currencies.first.code, "USD");

    expect(result.currencies.last.code, "JPY");
  });

  //-----------------------------------------------------
  //6
  //-----------------------------------------------------

  test("UpdatedAt should not be null", () async {
    when(() => remote.fetchLatestRates()).thenAnswer((_) async => response);

    when(() => local.saveCurrencies(any())).thenAnswer((_) async {});

    final result = await repository.fetchLatestRates();

    expect(result.updatedAt, isNotNull);
  });

  //-----------------------------------------------------
  //7
  //-----------------------------------------------------

  test("saveCurrencies called once", () async {
    when(() => remote.fetchLatestRates()).thenAnswer((_) async => response);

    when(() => local.saveCurrencies(any())).thenAnswer((_) async {});

    await repository.fetchLatestRates();

    verify(() => local.saveCurrencies(any())).called(1);

    verifyNoMoreInteractions(local);
  });

  //-----------------------------------------------------
  //8
  //-----------------------------------------------------

  test("getCurrencies called once", () async {
    when(() => remote.fetchLatestRates()).thenThrow(
      DioException(requestOptions: RequestOptions(path: '/rates/latest')),
    );

    when(() => local.getCurrencies()).thenAnswer((_) async => cache);

    await repository.fetchLatestRates();

    verify(() => local.getCurrencies()).called(1);
  });
}
