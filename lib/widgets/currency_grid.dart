import 'package:flutter/material.dart';
import 'package:divisapp/models/currency_view_model.dart';
import 'package:divisapp/widgets/currency_item.dart';

class CurrencyGrid extends StatelessWidget {
  final List<CurrencyViewModel> currencies;

  const CurrencyGrid({
    super.key,
    required this.currencies,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: currencies.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: CurrencyItem(
          currency: currencies[index],
          isDarkMode: isDarkMode,
        ),
      ),
    );
  }
}
