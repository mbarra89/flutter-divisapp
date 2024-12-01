import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:divisapp/providers/currency_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart'; // Importa el paquete logger

part 'currency_conversion_provider.g.dart';

// Instancia global de Logger
final logger = Logger();

@riverpod
Future<double> currencyConversion(
    Ref ref, String currencyCode, double amount) async {
  try {
    // Validar el código de moneda y obtener la moneda coincidente
    final matchingCurrency =
        await ref.read(currencyListProvider.future).then((currencyList) {
      return currencyList.firstWhere(
        (currency) =>
            currency.codigo.toLowerCase() == currencyCode.toLowerCase(),
        orElse: () => throw Exception('Invalid currency code: $currencyCode'),
      );
    });

    // Log en lugar de print
    logger.i('Converting for currency: ${matchingCurrency.codigo}');

    // Obtener el valor actual de la moneda específica
    final historicalCurrencyState =
        await ref.read(historicalCurrencyProvider(currencyCode).future);

    // Multiplicar la cantidad por el valor de la moneda actual
    return amount * historicalCurrencyState.todayValue;
  } catch (e) {
    // Manejo de diferentes tipos de errores con logger
    if (e.toString().contains('Invalid currency code')) {
      logger.e('Invalid currency code: $currencyCode');
      throw Exception('The provided currency code is not supported.');
    } else if (e is AsyncError) {
      logger.e('Failed to retrieve currency data. Check your connection.');
      throw Exception(
          'Failed to retrieve currency data. Please check your connection.');
    } else {
      logger.e('Unexpected error during currency conversion: $e');
      throw Exception(
          'An unexpected error occurred during currency conversion.');
    }
  }
}
