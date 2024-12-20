import 'package:divisapp/models/currency_view_model.dart';
import 'package:divisapp/providers/historical_provider.dart';
import 'package:divisapp/theme/app_theme.dart';
import 'package:divisapp/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CurrencyGraphWidget extends ConsumerWidget {
  final CurrencyViewModel currency;
  final List<dynamic> series;
  final String title;

  const CurrencyGraphWidget({
    super.key,
    required this.currency,
    required this.series,
    this.title = 'Evolución de Valores Económicos',
  });

  List<double> _calculateMinMaxValues() {
    if (series.isEmpty) return [0, 0];

    final values = series.map((point) => point.valor).toList();
    final minValue = values.reduce((curr, next) => curr < next ? curr : next);
    final maxValue = values.reduce((curr, next) => curr > next ? curr : next);

    // If all values are the same, add a small padding to create a visible interval
    if (minValue == maxValue) {
      return [minValue - 0.5, maxValue + 0.5];
    }

    final padding = (maxValue - minValue) * 0.1;
    return [minValue - padding, maxValue + padding];
  }

  LineChartData _buildLineChartData(BuildContext context) {
    final minMax = _calculateMinMaxValues();
    final intervalY = ((minMax[1] - minMax[0]) / 4).ceilToDouble();

    // Ensure intervalY is not zero
    final safeIntervalY = intervalY == 0 ? 0.1 : intervalY;

    // Reduce the number of X-axis labels to minimize truncation
    final intervalX =
        series.length > 5 ? (series.length / 4).floorToDouble() : 1;

    return LineChartData(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        verticalInterval: intervalX.toDouble(),
        horizontalInterval: safeIntervalY,
        getDrawingVerticalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.3),
          strokeWidth: 1,
        ),
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.3),
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: intervalX.toDouble(),
            getTitlesWidget: (value, meta) {
              final index = value.toInt();

              // Ensure the index is within the series range and matches the interval
              if (index >= 0 &&
                  index < series.length &&
                  index % intervalX.toInt() == 0) {
                final point = series[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat('MMM').format(point.fecha).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppTheme.neutralTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        DateFormat('dd').format(point.fecha),
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppTheme.neutralTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: safeIntervalY,
            getTitlesWidget: (value, meta) {
              // Verificar si esta etiqueta está en el borde de la cuadrícula o es mínimamente visible
              final isAtGridBoundary = value == minMax[0] || value == minMax[1];
              final isCompletelyVisible = value > meta.min && value < meta.max;

              // Mostrar la etiqueta solo si está en los bordes de la cuadrícula o completamente dentro de ella
              if (!isAtGridBoundary && !isCompletelyVisible) {
                return const SizedBox.shrink();
              }

              return Text(
                CurrencyFormatter.formatRate(value, currency.unidadMedida),
                style: const TextStyle(
                  fontSize: 10,
                  color: AppTheme.neutralTextColor,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
        ),
      ),
      minX: 0,
      maxX: (series.length - 1).toDouble(),
      minY: minMax[0],
      maxY: minMax[1],
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: series.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value.valor);
          }).toList(),
          isCurved: true,
          color: AppTheme.lineChartPrimaryColor,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 2,
                color: AppTheme.lineChartPrimaryColor,
                strokeWidth: 1,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.lineChartPrimaryColor.withOpacity(0.8),
                AppTheme.lineChartSecondaryColor.withOpacity(0.2),
              ],
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((touchedSpot) {
              final point = series[touchedSpot.x.toInt()];
              return LineTooltipItem(
                '${DateFormat('dd/MM/yyyy').format(point.fecha)}\n'
                'Valor: ${CurrencyFormatter.formatRate(point.valor, currency.unidadMedida)}',
                const TextStyle(
                  color: AppTheme.darkTextColor,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyChange = ref
        .read(historicalSeriesProvider(currency.codigo).notifier)
        .getDailyChange();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                CurrencyFormatter.formatRate(
                    currency.valor, currency.unidadMedida),
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkTextColor),
              ),
              // Text(
              //   dailyChange.toStringAsFixed(4),
              //   style: TextStyle(
              //       fontSize: 12,
              //       color: dailyChange >= 0
              //           ? AppTheme.upIndicatorColor
              //           : AppTheme.downIndicatorColor,
              //       fontWeight: FontWeight.bold),
              // ),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1.6,
          child: LineChart(_buildLineChartData(context)),
        ),
      ],
    );
  }
}
