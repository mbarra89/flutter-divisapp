import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final _chileanPesosFormat = NumberFormat('#,##0', 'es_CL');
  static const _unidadesMonetarias = {'Pesos', 'Dólar'};
  static const _unidadPorcentaje = 'Porcentaje';

  static String formatRate(double? rate, String? unidadMedida) {
    if (rate == null || unidadMedida == null) {
      return '0.00';
    }
    if (_unidadesMonetarias.contains(unidadMedida)) {
      return _formatearMoneda(rate);
    } else if (unidadMedida == _unidadPorcentaje) {
      return _formatearPorcentaje(rate);
    }
    return _formatearDecimal(rate);
  }

  static String _formatearMoneda(double monto) {
    return '\$${_chileanPesosFormat.format(monto)}';
  }

  static String _formatearPorcentaje(double valor) {
    return '${_formatearDecimal(valor)}%';
  }

  static String _formatearDecimal(double valor) {
    return valor.toStringAsFixed(2);
  }
}
