import 'package:divisapp/models/currency_view_model.dart';
import 'package:divisapp/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'currency_provider.g.dart';

// Simple class to hold historical data
class HistoricalCurrencyState {
  final double todayValue;
  final double yesterdayValue;
  final DateTime todayDate;
  final DateTime yesterdayDate;
  final String percentageChange;

  HistoricalCurrencyState({
    required this.todayValue,
    required this.yesterdayValue,
    required this.todayDate,
    required this.yesterdayDate,
    required this.percentageChange,
  });
}

@riverpod
class CurrencyList extends _$CurrencyList {
  final _logger = Logger();
  late final ApiService _apiService;

  @override
  Future<List<CurrencyViewModel>> build() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _apiService = ApiService(
        client: http.Client(),
        prefs: prefs,
      );
      return await _apiService.getCurrencies();
    } catch (e, stack) {
      _logger.e('Error al construir CurrencyList', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _apiService.getCurrencies());
  }

  IconData getIconForCurrency(String code) {
    return _apiService.getIconForCurrency(code);
  }

  String getShortName(String code) {
    return ApiConstants.currencyNames[code.toLowerCase()] ?? code;
  }
}

@riverpod
class HistoricalCurrency extends _$HistoricalCurrency {
  final _logger = Logger();
  late final ApiService _apiService;

  @override
  Future<HistoricalCurrencyState> build(String currencyCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _apiService = ApiService(
        client: http.Client(),
        prefs: prefs,
      );

      final historicalData =
          await _apiService.getHistoricalCurrencyData(currencyCode);
      final percentageChange =
          _apiService.calculatePercentageChange(historicalData);

      return HistoricalCurrencyState(
        todayValue: historicalData.todayValue,
        yesterdayValue: historicalData.yesterdayValue,
        todayDate: historicalData.todayDate,
        yesterdayDate: historicalData.yesterdayDate,
        percentageChange: percentageChange,
      );
    } catch (e, stack) {
      _logger.e('Error al obtener datos históricos',
          error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build(currencyCode));
  }
}
