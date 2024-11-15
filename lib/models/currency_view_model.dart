import 'package:flutter/material.dart';
import 'currency.dart';

class CurrencyViewModel {
  final Currency currency;
  final String titulo;
  final IconData icon;

  CurrencyViewModel({
    required this.currency,
    required this.titulo,
    required this.icon,
  });

  String get codigo => currency.codigo;
  String get nombre => currency.nombre;
  String get unidadMedida => currency.unidadMedida;
  DateTime get fecha => currency.fecha;
  double get valor => currency.valor;

  factory CurrencyViewModel.fromCurrency(
    Currency currency, {
    required String titulo,
    required IconData icon,
  }) {
    return CurrencyViewModel(
      currency: currency,
      titulo: titulo,
      icon: icon,
    );
  }
}
