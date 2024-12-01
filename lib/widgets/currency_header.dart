import 'package:divisapp/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CurrencyHeader extends StatelessWidget {
  final String currencyCode;
  final String currencyName;
  final bool isFromCurrency;
  final VoidCallback? onCurrencyTap;

  const CurrencyHeader({
    super.key,
    required this.currencyCode,
    required this.currencyName,
    this.isFromCurrency = true,
    this.onCurrencyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            currencyCode == 'uf' || currencyCode == 'CLP'
                ? 'assets/images/clp.png'
                : currencyCode == 'dolar' || currencyCode == 'USD'
                    ? 'assets/images/usd.png'
                    : currencyCode == 'euro' || currencyCode == 'EUR'
                        ? 'assets/images/eur.png'
                        : 'assets/images/usd.png', // default fallback
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.neutralTextColor,
                  ),
              children: [
                TextSpan(
                  text: isFromCurrency ? 'Desde\n' : 'A\n',
                  style: const TextStyle(color: AppTheme.accentGoldColor),
                ),
                TextSpan(
                  text: '$currencyCode - $currencyName',
                  style: const TextStyle(
                    color: AppTheme.darkTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isFromCurrency && onCurrencyTap != null)
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: onCurrencyTap,
              child: const CircleAvatar(
                radius: 20.0,
                backgroundColor: AppTheme.accentGoldColor,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: AppTheme.accentButtonTextColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
