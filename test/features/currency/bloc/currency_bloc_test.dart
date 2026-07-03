import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:vietpay_app/features/currency/bloc/currency_bloc.dart';
import 'package:vietpay_app/features/currency/bloc/currency_event.dart';
import 'package:vietpay_app/features/currency/bloc/currency_state.dart';

import 'package:vietpay_app/features/currency/models/currency_model.dart';
import 'package:vietpay_app/features/currency/models/currency_result.dart';

import 'package:vietpay_app/features/currency/repository/currency_repository.dart';

class MockCurrencyRepository extends Mock implements CurrencyRepository {}

void main() {
  late CurrencyBloc bloc;
  late MockCurrencyRepository repository;

  final updatedAt = DateTime(2026, 7, 12);

  final currencies = [
    CurrencyModel(code: "USD", rate: 1, updatedAt: updatedAt),
    CurrencyModel(code: "VND", rate: 26000, updatedAt: updatedAt),
    CurrencyModel(code: "JPY", rate: 147, updatedAt: updatedAt),
  ];

  setUp(() {
    repository = MockCurrencyRepository();
    bloc = CurrencyBloc(repository);
  });

  tearDown(() {
    bloc.close();
  });

  //------------------------------------------------------
  //1 Initial State
  //------------------------------------------------------

  test("Initial state is CurrencyLoading", () {
    expect(bloc.state, isA<CurrencyLoading>());
  });

  //------------------------------------------------------
  //2 API Success
  //------------------------------------------------------

  blocTest<CurrencyBloc, CurrencyState>(
    "Loading -> Loaded from API",
    build: () {
      when(() => repository.fetchLatestRates()).thenAnswer(
        (_) async => CurrencyResult(
          currencies: currencies,
          isFromCache: false,
          updatedAt: updatedAt,
        ),
      );

      return bloc;
    },
    act: (bloc) => bloc.add(const LoadCurrencies()),
    expect: () => [isA<CurrencyLoading>(), isA<CurrencyLoaded>()],
  );

  //------------------------------------------------------
  //3 Cache Success
  //------------------------------------------------------

  blocTest<CurrencyBloc, CurrencyState>(
    "Loading -> Loaded from Cache",
    build: () {
      when(() => repository.fetchLatestRates()).thenAnswer(
        (_) async => CurrencyResult(
          currencies: currencies,
          isFromCache: true,
          updatedAt: updatedAt,
        ),
      );

      return bloc;
    },
    act: (bloc) => bloc.add(const LoadCurrencies()),
    verify: (_) {
      final state = bloc.state as CurrencyLoaded;

      expect(state.isOffline, true);
    },
  );

  //------------------------------------------------------
  //4 Repository Error
  //------------------------------------------------------

  blocTest<CurrencyBloc, CurrencyState>(
    "Loading -> Error",
    build: () {
      when(
        () => repository.fetchLatestRates(),
      ).thenThrow(Exception("Network Error"));

      return bloc;
    },
    act: (bloc) => bloc.add(const LoadCurrencies()),
    expect: () => [isA<CurrencyLoading>(), isA<CurrencyError>()],
  );

  //------------------------------------------------------
  //5 Repository called once
  //------------------------------------------------------

  blocTest<CurrencyBloc, CurrencyState>(
    "Repository called once",
    build: () {
      when(() => repository.fetchLatestRates()).thenAnswer(
        (_) async => CurrencyResult(
          currencies: currencies,
          isFromCache: false,
          updatedAt: updatedAt,
        ),
      );

      return bloc;
    },
    act: (bloc) => bloc.add(const LoadCurrencies()),
    verify: (_) {
      verify(() => repository.fetchLatestRates()).called(1);
    },
  );

  //------------------------------------------------------
  //6 Online
  //------------------------------------------------------

  blocTest<CurrencyBloc, CurrencyState>(
    "Loaded should be online",
    build: () {
      when(() => repository.fetchLatestRates()).thenAnswer(
        (_) async => CurrencyResult(
          currencies: currencies,
          isFromCache: false,
          updatedAt: updatedAt,
        ),
      );

      return bloc;
    },
    act: (bloc) => bloc.add(const LoadCurrencies()),
    verify: (_) {
      final state = bloc.state as CurrencyLoaded;

      expect(state.isOffline, false);
    },
  );

  //------------------------------------------------------
  //7 Offline
  //------------------------------------------------------

  blocTest<CurrencyBloc, CurrencyState>(
    "Loaded should be offline",
    build: () {
      when(() => repository.fetchLatestRates()).thenAnswer(
        (_) async => CurrencyResult(
          currencies: currencies,
          isFromCache: true,
          updatedAt: updatedAt,
        ),
      );

      return bloc;
    },
    act: (bloc) => bloc.add(const LoadCurrencies()),
    verify: (_) {
      final state = bloc.state as CurrencyLoaded;

      expect(state.isOffline, true);
    },
  );

  //------------------------------------------------------
  //8 Currency Count
  //------------------------------------------------------

  blocTest<CurrencyBloc, CurrencyState>(
    "Currency count should be 3",
    build: () {
      when(() => repository.fetchLatestRates()).thenAnswer(
        (_) async => CurrencyResult(
          currencies: currencies,
          isFromCache: false,
          updatedAt: updatedAt,
        ),
      );

      return bloc;
    },
    act: (bloc) => bloc.add(const LoadCurrencies()),
    verify: (_) {
      final state = bloc.state as CurrencyLoaded;

      expect(state.currencies.length, 3);
    },
  );

  //------------------------------------------------------
  //9 UpdatedAt
  //------------------------------------------------------

  blocTest<CurrencyBloc, CurrencyState>(
    "UpdatedAt should be passed correctly",
    build: () {
      when(() => repository.fetchLatestRates()).thenAnswer(
        (_) async => CurrencyResult(
          currencies: currencies,
          isFromCache: false,
          updatedAt: updatedAt,
        ),
      );

      return bloc;
    },
    act: (bloc) => bloc.add(const LoadCurrencies()),
    verify: (_) {
      final state = bloc.state as CurrencyLoaded;

      expect(state.updatedAt, updatedAt);
    },
  );

  //------------------------------------------------------
  //10 Multiple events
  //------------------------------------------------------

  blocTest<CurrencyBloc, CurrencyState>(
    "Multiple LoadCurrencies events",
    build: () {
      when(() => repository.fetchLatestRates()).thenAnswer(
        (_) async => CurrencyResult(
          currencies: currencies,
          isFromCache: false,
          updatedAt: updatedAt,
        ),
      );

      return bloc;
    },
    act: (bloc) {
      bloc.add(const LoadCurrencies());
      bloc.add(const LoadCurrencies());
    },
    verify: (_) {
      verify(() => repository.fetchLatestRates()).called(2);
    },
  );
}
