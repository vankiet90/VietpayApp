import 'package:equatable/equatable.dart';

import '../models/currency_model.dart';

abstract class CurrencyState extends Equatable {
  const CurrencyState();

  @override
  List<Object?> get props => [];
}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<CurrencyModel> currencies;

  final bool isOffline;

  final DateTime updatedAt;

  const CurrencyLoaded({
    required this.currencies,
    required this.isOffline,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [currencies, isOffline, updatedAt];
}

class CurrencyError extends CurrencyState {
  final String message;

  const CurrencyError(this.message);

  @override
  List<Object?> get props => [message];
}
