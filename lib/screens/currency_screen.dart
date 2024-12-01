import 'package:divisapp/models/currency_view_model.dart';
import 'package:divisapp/providers/currency_provider.dart';
import 'package:divisapp/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:divisapp/widgets/currency_grid.dart';

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

  // Método para construir el campo de búsqueda
  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Buscar por nombre de moneda',
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF141416),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      style: const TextStyle(color: Colors.white),
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
    );
  }

  // Método para construir el AppBar completo
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.appBarBackgroundColor,
      title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.jpeg'),
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.neutralTextColor,
                          ),
                      children: const [
                        TextSpan(
                          text: 'Welcome back\n',
                        ),
                        TextSpan(
                          text: 'Miguel',
                          style: TextStyle(
                            color: AppTheme
                                .darkTextColor, // Color personalizado para nombre
                            fontWeight: FontWeight
                                .bold, // Fuente personalizada (puedes cambiar)
                            fontSize:
                                18.0, // Tamaño de fuente específico para nombre
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              _buildSearchField(),
            ],
          )),
      toolbarHeight: 150,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Utilizamos el nuevo método para construir el AppBar
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: CurrencyGrid(currencies: _filteredCurrencies),
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
    return Scaffold(
      body: Center(
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
      ),
    );
  }
}

/// Vista de carga
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
