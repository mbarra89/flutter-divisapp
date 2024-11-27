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

    final padding = (maxValue - minValue) * 0.1;
    return [minValue - padding, maxValue + padding];
  }

  LineChartData _buildLineChartData(BuildContext context) {
    final minMax = _calculateMinMaxValues();
    final intervalY = ((minMax[1] - minMax[0]) / 4).ceilToDouble();

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
        horizontalInterval: intervalY,
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
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        DateFormat('dd').format(point.fecha),
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey[600],
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
            interval: intervalY,
            getTitlesWidget: (value, meta) {
              if (value == minMax[0]) return const SizedBox.shrink();
              return Text(
                CurrencyFormatter.formatRate(value, currency.unidadMedida),
                style: const TextStyle(
                  fontSize: 10,
                  color: AppTheme.infoColor,
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
          color: Colors.deepPurple[600],
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 5,
                color: Colors.deepPurple[600]!,
                strokeWidth: 2,
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
                Colors.deepPurple[300]!.withOpacity(0.4),
                Colors.deepPurple[100]!.withOpacity(0.1),
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
                'Valor: ${point.valor.toStringAsFixed(2)} UF',
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
    final historicalData = ref.watch(historicalSeriesProvider(currency.codigo));
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
              Text(
                dailyChange.toStringAsFixed(4),
                style: TextStyle(
                  fontSize: 12,
                  color: dailyChange >= 0
                      ? AppTheme.upIndicatorColor
                      : AppTheme.downIndicatorColor,
                ),
              ),
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
