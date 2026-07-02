import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../bloc/currency_bloc.dart';
import '../bloc/currency_event.dart';
import '../bloc/currency_state.dart';
import '../widgets/converter_section.dart';
import '../widgets/currency_list.dart';
import '../widgets/last_updated_widget.dart';
import '../widgets/offline_banner.dart';
import '../widgets/saved_currency_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CurrencyBloc>()..add(const LoadCurrencies()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Converter"),
        centerTitle: true,
      ),
      body: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CurrencyError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(state.message, textAlign: TextAlign.center),
              ),
            );
          }

          if (state is CurrencyLoaded) {
            return _LoadedView(state: state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final CurrencyLoaded state;

  const _LoadedView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (state.isOffline) const OfflineBanner(),

        LastUpdatedWidget(updatedAt: state.updatedAt),

        SavedCurrencyCard(currencies: state.currencies),

        ConverterSection(currencies: state.currencies),

        Expanded(child: CurrencyList(currencies: state.currencies)),
      ],
    );
  }
}
