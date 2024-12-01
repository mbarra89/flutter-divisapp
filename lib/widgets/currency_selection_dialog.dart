import 'package:divisapp/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CurrencySelectionDialog extends StatelessWidget {
  final void Function(String) onCurrencySelected;

  const CurrencySelectionDialog({
    super.key,
    required this.onCurrencySelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Seleccionar Moneda',
        style: TextStyle(
          color: AppTheme.darkTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCurrencyOption(context, 'dolar', 'USD (Dólar Americano)'),
          _buildCurrencyOption(context, 'uf', 'UF'),
          _buildCurrencyOption(context, 'euro', 'Euro'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: AppTheme.accentGoldColor),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencyOption(BuildContext context, String code, String label) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(
          color: AppTheme.darkTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        onCurrencySelected(code);
        Navigator.of(context).pop();
      },
    );
  }
}
