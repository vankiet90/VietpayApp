import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vietpay_app/core/constants/app_constants.dart';
import '../../../core/di/service_locator.dart';
import '../bloc/currency_bloc.dart';
import '../bloc/currency_event.dart';
import '../bloc/currency_state.dart';
import '../widgets/currency_list.dart';
import '../widgets/last_updated_widget.dart';
import '../widgets/offline_banner.dart';

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
        title: const Text(AppConstants.appName),
        centerTitle: true,
      ),
      body: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          /// Loading
          if (state is CurrencyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// Error
          if (state is CurrencyError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          /// Loaded
          if (state is CurrencyLoaded) {
            return Column(
              children: [
                if (state.isOffline) const OfflineBanner(),

                LastUpdatedWidget(updatedAt: state.updatedAt),

                const Divider(height: 1),

                Expanded(child: CurrencyList(currencies: state.currencies)),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
