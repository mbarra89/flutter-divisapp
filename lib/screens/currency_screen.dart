import 'package:divisapp/models/currency_view_model.dart';
import 'package:divisapp/providers/currency_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:divisapp/widgets/currency_grid.dart';
import 'package:divisapp/widgets/update_info_header.dart';

/// Pantalla principal que muestra la lista de divisas
class CurrencyScreen extends ConsumerWidget {
  const CurrencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currenciesAsync = ref.watch(currencyListProvider);
    return Scaffold(
      body: currenciesAsync.when(
        data: (currencies) => _CurrencyListView(
          currencies: currencies,
          onRefresh: ref.read(currencyListProvider.notifier).refresh,
        ),
        error: (error, stackTrace) => _ErrorView(error: error),
        loading: () => const _LoadingView(),
      ),
    );
  }
}

/// Vista que muestra la lista de divisas
class _CurrencyListView extends StatefulWidget {
  final List<CurrencyViewModel> currencies;
  final Future<void> Function() onRefresh;

  const _CurrencyListView({
    required this.currencies,
    required this.onRefresh,
  });

  @override
  State<_CurrencyListView> createState() => _CurrencyListViewState();
}

class _CurrencyListViewState extends State<_CurrencyListView> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CurrencyViewModel> get _filteredCurrencies {
    if (_searchQuery.isEmpty) {
      return widget.currencies;
    }
    return widget.currencies
        .where((currency) =>
            currency.nombre.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: Column(
        children: [
          const UpdateInfoHeader(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por nombre de moneda',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: CurrencyGrid(currencies: _filteredCurrencies),
          ),
        ],
      ),
    );
  }
}

/// Vista de error
class _ErrorView extends StatelessWidget {
  final Object error;
  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error: $error',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

/// Vista de carga
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
