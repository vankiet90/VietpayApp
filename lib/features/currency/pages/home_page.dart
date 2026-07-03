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
            return Center(
              child: CircularProgressIndicator(
                key: const Key("loading_indicator"),
              ),
            );
          }

          if (state is CurrencyError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off, size: 64, color: Colors.orange),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      key: const Key("error_text"),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      key: const Key("retry_button"),
                      onPressed: () {
                        context.read<CurrencyBloc>().add(
                          const LoadCurrencies(),
                        );
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.isOffline) const OfflineBanner(),

          LastUpdatedWidget(updatedAt: state.updatedAt),

          SavedCurrencyCard(currencies: state.currencies),

          ConverterSection(currencies: state.currencies),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Currencies",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          CurrencyList(currencies: state.currencies),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
