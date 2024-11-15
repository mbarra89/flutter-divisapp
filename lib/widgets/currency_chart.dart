import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CurrencyChart extends StatelessWidget {
  final double todayValue;
  final double yesterdayValue;
  final Color lineColor;
  final bool isDarkMode;

  const CurrencyChart({
    super.key,
    required this.todayValue,
    required this.yesterdayValue,
    required this.lineColor,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 80,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, yesterdayValue),
                FlSpot(1, todayValue),
              ],
              isCurved: true,
              color: lineColor,
              barWidth: 2,
              isStrokeCapRound: false,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: lineColor.withOpacity(0.1),
              ),
            ),
          ],
          minX: 0,
          maxX: 1,
          minY: [yesterdayValue, todayValue].reduce((a, b) => a < b ? a : b) *
              0.99,
          maxY: [yesterdayValue, todayValue].reduce((a, b) => a > b ? a : b) *
              1.01,
        ),
      ),
    );
  }
}
