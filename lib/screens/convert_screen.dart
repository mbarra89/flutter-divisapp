import 'package:divisapp/providers/currency_conversion_provider.dart';
import 'package:divisapp/router.dart';
import 'package:divisapp/theme/app_theme.dart';
import 'package:divisapp/utils/currency_formatter.dart';
import 'package:divisapp/widgets/currency_header.dart';
import 'package:divisapp/widgets/currency_info_dialog.dart';
import 'package:divisapp/widgets/currency_result_display.dart';
import 'package:divisapp/widgets/currency_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CurrencyConverterScreen extends ConsumerStatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState
    extends ConsumerState<CurrencyConverterScreen> {
  // Currency conversion state
  String _fromCurrency = 'dolar';
  String _conversionResult = '0.00';
  final TextEditingController _amountController = TextEditingController();

  // Map of currency codes to full names
  static const Map<String, String> _currencyNames = {
    'dolar': 'Dólar Americano',
    'uf': 'Unidad de Fomento',
    'euro': 'Euro',
  };

  void _updateFromCurrency(String currency) {
    setState(() {
      _fromCurrency = currency;
    });
  }

  Future<void> _performConversion() async {
    try {
      // Input validation
      if (_amountController.text.isEmpty) {
        _showErrorSnackBar('Por favor, ingrese un monto');
        return;
      }

      final amount = double.tryParse(_amountController.text);
      if (amount == null) {
        _showErrorSnackBar('Monto inválido');
        return;
      }

      // Perform conversion
      final result = await ref
          .read(currencyConversionProvider(_fromCurrency, amount).future);

      setState(() {
        _conversionResult = CurrencyFormatter.formatRate(result, 'Pesos');
      });
    } catch (e) {
      _showErrorSnackBar('Error en la conversión: ${e.toString()}');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildCurrencyConverterCard(context),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 70,
      leading: _buildLeadingBackButton(context),
      title: const Text(
        "Conversor",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [_buildInfoButton(context)],
    );
  }

  Widget _buildLeadingBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Center(
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.iconBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.go(AppRoute.home.path),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Center(
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.iconBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => CurrencyInfoDialog.show(context),
            icon: const Icon(Icons.info_outline),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyConverterCard(BuildContext context) {
    return Card(
      color: AppTheme.darkSurfaceColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CurrencyHeader(
              currencyCode: _fromCurrency,
              currencyName: _currencyNames[_fromCurrency]!,
              onCurrencyTap: () => _showCurrencySelectionDialog(context),
            ),
            const SizedBox(height: 12),
            FutureBuilder<Widget>(
              future: _buildExchangeRateText(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return snapshot.data ?? const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 12),
            _buildAmountTextField(),
            const SizedBox(height: 12),
            const Divider(color: Colors.grey, thickness: 2.0),
            const SizedBox(height: 12),
            const CurrencyHeader(
              currencyCode: 'CLP',
              currencyName: 'Peso Chileno',
              isFromCurrency: false,
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 12),
            ConversionResultDisplay(conversionResult: _conversionResult),
            const SizedBox(height: 12),
            _buildConvertButton(),
          ],
        ),
      ),
    );
  }

  Future<Widget> _buildExchangeRateText() async {
    final result =
        await ref.read(currencyConversionProvider(_fromCurrency, 1).future);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            // ignore: use_build_context_synchronously
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.neutralTextColor,
                ),
            children: [
              TextSpan(
                text: '1 $_fromCurrency = $result CLP',
                style: const TextStyle(
                  color: AppTheme.neutralTextColor,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountTextField() {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Monto',
        hintText: 'Ingrese el monto a convertir',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(
          Icons.monetization_on,
          color: AppTheme.accentGoldColor,
        ),
      ),
      style: const TextStyle(
        color: AppTheme.darkTextColor,
        fontSize: 16.0,
      ),
    );
  }

  Widget _buildConvertButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _performConversion,
        style: ElevatedButton.styleFrom(
          foregroundColor: AppTheme.accentButtonTextColor,
          backgroundColor: AppTheme.accentGoldColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Convertir',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  void _showCurrencySelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CurrencySelectionDialog(
          onCurrencySelected: (currency) {
            _updateFromCurrency(currency);
          },
        );
      },
    );
  }
}
