import 'package:divisapp/services/historical_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'historical_provider.g.dart';

class HistoricalSeriesState {
  final List<SerieEntry> series;
  final Map<String, dynamic> statistics;
  final String currencyName;
  final String unitOfMeasure;

  HistoricalSeriesState({
    required this.series,
    required this.statistics,
    required this.currencyName,
    required this.unitOfMeasure,
  });
}

@riverpod
class HistoricalSeries extends _$HistoricalSeries {
  final _logger = Logger();
  late final HistoricalService _historicalService;

  @override
  Future<HistoricalSeriesState> build(String currencyCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _historicalService = HistoricalService(
        client: http.Client(),
        prefs: prefs,
      );

      final historicalData =
          await _historicalService.getHistoricalSeries(currencyCode);
      final statistics =
          _historicalService.calculateHistoricalStats(historicalData);

      return HistoricalSeriesState(
        series: historicalData.serie,
        statistics: statistics,
        currencyName: historicalData.nombre,
        unitOfMeasure: historicalData.unidadMedida,
      );
    } catch (e, stack) {
      _logger.e('Error al obtener serie histórica',
          error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build(currencyCode));
  }

  double getAverageValue() {
    return state.value?.statistics['average'] ?? 0.0;
  }

  double getMedianValue() {
    return state.value?.statistics['median'] ?? 0.0;
  }

  double getMinValue() {
    return state.value?.statistics['minimum'] ?? 0.0;
  }

  double getMaxValue() {
    return state.value?.statistics['maximum'] ?? 0.0;
  }

  DateTimeRange getDateRange() {
    if (state.value == null) {
      return DateTimeRange(start: DateTime.now(), end: DateTime.now());
    }

    final dateRange =
        state.value!.statistics['dateRange'] as Map<String, DateTime>;
    return DateTimeRange(
      start: dateRange['from']!,
      end: dateRange['to']!,
    );
  }

  List<SerieEntry> getSeriesForRange(DateTimeRange range) {
    if (state.value == null) return [];

    return state.value!.series.where((entry) {
      return entry.fecha.isAfter(range.start) &&
          entry.fecha.isBefore(range.end);
    }).toList();
  }

  double getDailyChange() {
    if (state.value == null || state.value!.series.length < 2) {
      return 0.0;
    }

    final series = state.value!.series;
    final today = series.last.valor;
    final yesterday = series[series.length - 2].valor;
    return ((today - yesterday) / yesterday * 100);
  }
}
