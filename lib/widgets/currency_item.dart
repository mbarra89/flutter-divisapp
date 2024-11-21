import 'package:flutter/material.dart';
import 'package:divisapp/models/currency_view_model.dart';
import 'package:divisapp/theme/app_theme.dart';
import 'package:divisapp/utils/currency_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:divisapp/providers/currency_provider.dart';
import 'package:go_router/go_router.dart';

class CurrencyItem extends ConsumerWidget {
  final CurrencyViewModel currency;
  final bool isDarkMode;

  const CurrencyItem({
    super.key,
    required this.currency,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historicalData =
        ref.watch(historicalCurrencyProvider(currency.codigo));
    final backgroundColor =
        isDarkMode ? AppTheme.darkSurfaceColor : Colors.white;
    final textColor =
        isDarkMode ? AppTheme.darkTextColor : AppTheme.lightTextColor;

    return GestureDetector(
      onTap: () => context.go('/currency/${currency.codigo}', extra: currency),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: _CurrencyItemContent(
            currency: currency,
            textColor: textColor,
            isDarkMode: isDarkMode,
            historicalData: historicalData,
          ),
        ),
      ),
    );
  }
}

class _CurrencyItemContent extends StatelessWidget {
  final CurrencyViewModel currency;
  final Color textColor;
  final bool isDarkMode;
  final AsyncValue<HistoricalCurrencyState> historicalData;

  const _CurrencyItemContent({
    required this.currency,
    required this.textColor,
    required this.isDarkMode,
    required this.historicalData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCurrencyInfo(),
              const SizedBox(height: 4),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildValue(),
            const SizedBox(height: 4),
            _buildValueYesterday(),
          ],
        ),
      ],
    );
  }

  Widget _buildCurrencyInfo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(currency.icon, size: 24, color: textColor),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                currency.titulo,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                currency.nombre,
                style: TextStyle(
                  fontSize: 12,
                  color: textColor.withOpacity(0.6),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValueYesterday() {
    return historicalData.when(
      data: (data) {
        final percentageColor = _getPercentageColor(data.percentageChange);
        return Container(
          width: 85,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: percentageColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: percentageColor,
              width: 1,
            ),
          ),
          child: Text(
            data.percentageChange,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.end,
          ),
        );
      },
      loading: () => const SizedBox(
        height: 24,
        width: 85,
        child: Center(
          child: SizedBox(
            height: 10,
            width: 10,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Color _getPercentageColor(String percentage) {
    final value = double.tryParse(percentage.replaceAll('%', '')) ?? 0;
    if (value > 0) return const Color(0xFF00B07C);
    if (value < 0) return const Color(0xFFE63946);
    return textColor.withOpacity(0.6);
  }

  Widget _buildValue() {
    return Container(
      width: 85,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        CurrencyFormatter.formatRate(currency.valor, currency.unidadMedida),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: textColor,
        ),
        textAlign: TextAlign.end,
      ),
    );
  }
}
