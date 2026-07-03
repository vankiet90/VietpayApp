import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/currency_repository.dart';
import 'currency_event.dart';
import 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyRepository repository;

  CurrencyBloc(this.repository) : super(CurrencyLoading()) {
    on<LoadCurrencies>(_onLoadCurrencies);
  }

  Future<void> _onLoadCurrencies(
    LoadCurrencies event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(CurrencyLoading());

    try {
      final result = await repository.fetchLatestRates();

      emit(
        CurrencyLoaded(
          currencies: result.currencies,
          isOffline: result.isFromCache,
          updatedAt: result.updatedAt,
        ),
      );
    } catch (e) {
      emit(CurrencyError(message: e.toString()));
    }
  }
}
