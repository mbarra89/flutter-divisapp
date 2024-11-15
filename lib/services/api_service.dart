import 'dart:convert';
import 'package:divisapp/models/currency.dart';
import 'package:divisapp/models/currency_view_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiConstants {
  static const String baseUrl = 'https://mindicador.cl/api';
  static const String cacheKey = 'currency_data';
  static const String lastUpdatedKey = 'last_updated';
  static const String historicalCacheKeyPrefix = 'historical_';
  static const int cacheValidityHours = 1;

  static const Map<String, String> currencyNames = {
    'uf': 'UF',
    'ivp': 'IVP',
    'dolar': 'DOL',
    'dolar_intercambio': 'DII',
    'euro': 'EUR',
    'ipc': 'IPC',
    'utm': 'UTM',
    'imacec': 'IMA',
    'tpm': 'TPM',
    'libra_cobre': 'LBC',
    'tasa_desempleo': 'TDD',
    'bitcoin': 'BTC',
  };

  static const currencyIcons = {
    'uf': Icons.home,
    'ivp': Icons.trending_up,
    'dolar': Icons.attach_money,
    'dolar_intercambio': Icons.money_off,
    'euro': Icons.euro,
    'ipc': Icons.pie_chart,
    'utm': Icons.calculate,
    'imacec': Icons.bar_chart,
    'tpm': Icons.show_chart,
    'libra_cobre': Icons.account_balance_wallet,
    'tasa_desempleo': Icons.work_off,
    'bitcoin': Icons.currency_bitcoin,
  };
}

class HistoricalCurrencyData {
  final double todayValue;
  final double yesterdayValue;
  final DateTime todayDate;
  final DateTime yesterdayDate;

  HistoricalCurrencyData({
    required this.todayValue,
    required this.yesterdayValue,
    required this.todayDate,
    required this.yesterdayDate,
  });

  Map<String, dynamic> toJson() => {
        'todayValue': todayValue,
        'yesterdayValue': yesterdayValue,
        'todayDate': todayDate.toIso8601String(),
        'yesterdayDate': yesterdayDate.toIso8601String(),
      };

  factory HistoricalCurrencyData.fromJson(Map<String, dynamic> json) {
    return HistoricalCurrencyData(
      todayValue: json['todayValue'].toDouble(),
      yesterdayValue: json['yesterdayValue'].toDouble(),
      todayDate: DateTime.parse(json['todayDate']),
      yesterdayDate: DateTime.parse(json['yesterdayDate']),
    );
  }
}

class CacheManager {
  final SharedPreferences _prefs;

  CacheManager(this._prefs);

  Future<void> saveToCache(String key, String data) async {
    await _prefs.setString(key, data);
    await _prefs.setString(
      '${key}_${ApiConstants.lastUpdatedKey}',
      DateTime.now().toIso8601String(),
    );
  }

  String? getFromCache(String key) {
    return _prefs.getString(key);
  }

  bool isCacheValid(String key) {
    final lastUpdated =
        _prefs.getString('${key}_${ApiConstants.lastUpdatedKey}');
    if (lastUpdated == null) return false;

    final lastUpdatedDate = DateTime.tryParse(lastUpdated);
    if (lastUpdatedDate == null) return false;

    return DateTime.now().difference(lastUpdatedDate).inHours <
        ApiConstants.cacheValidityHours;
  }

  Future<void> clearCache() async {
    final keys = _prefs.getKeys().where((key) =>
        key.startsWith(ApiConstants.cacheKey) ||
        key.startsWith(ApiConstants.historicalCacheKeyPrefix));

    for (final key in keys) {
      await _prefs.remove(key);
    }
  }
}

class ApiClient {
  final http.Client _client;
  final Logger _logger;

  ApiClient(this._client, this._logger);

  Future<String> fetchData() async {
    try {
      final uri = Uri.parse(ApiConstants.baseUrl);
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Error al cargar divisas: ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Error en la petición HTTP: $e');
      throw Exception('Error en la petición HTTP: $e');
    }
  }

  Future<http.Response> get(Uri uri) async {
    try {
      return await _client.get(uri);
    } catch (e) {
      _logger.e('Error en la petición HTTP: $e');
      throw Exception('Error en la petición HTTP: $e');
    }
  }
}

class ApiService {
  final Logger _logger;
  final ApiClient _apiClient;
  final CacheManager _cacheManager;

  ApiService({
    required http.Client client,
    required SharedPreferences prefs,
  })  : _logger = Logger(),
        _apiClient = ApiClient(client, Logger()),
        _cacheManager = CacheManager(prefs);

  IconData getIconForCurrency(String code) {
    return ApiConstants.currencyIcons[code.toLowerCase()] ?? Icons.help_outline;
  }

  Future<List<CurrencyViewModel>> getCurrencies() async {
    try {
      if (_cacheManager.isCacheValid(ApiConstants.cacheKey)) {
        final cachedData = _cacheManager.getFromCache(ApiConstants.cacheKey);
        if (cachedData != null) {
          _logger.d('Using cached currency data');
          return _processData(cachedData);
        }
      }

      _logger.d('Fetching fresh currency data from API');
      final responseData = await _apiClient.fetchData();
      await _cacheManager.saveToCache(ApiConstants.cacheKey, responseData);
      return _processData(responseData);
    } catch (e) {
      final cachedData = _cacheManager.getFromCache(ApiConstants.cacheKey);
      if (cachedData != null) {
        _logger.w('Using expired cache due to API error: $e');
        return _processData(cachedData);
      }
      _logger.e('Error al obtener divisas: $e');
      throw Exception('Error al obtener divisas: $e');
    }
  }

  Future<HistoricalCurrencyData> getHistoricalCurrencyData(
      String currencyCode) async {
    final cacheKey = '${ApiConstants.historicalCacheKeyPrefix}$currencyCode';

    try {
      // Intentar usar caché primero
      if (_cacheManager.isCacheValid(cacheKey)) {
        final cachedData = _cacheManager.getFromCache(cacheKey);
        if (cachedData != null) {
          _logger.d('Using cached historical data for $currencyCode');
          return HistoricalCurrencyData.fromJson(json.decode(cachedData));
        }
      }

      // Si no hay caché válido, obtener de la API
      _logger.d('Fetching fresh historical data for $currencyCode');
      final uri = Uri.parse('${ApiConstants.baseUrl}/$currencyCode');
      final response = await _apiClient.get(uri);

      if (response.statusCode != 200) {
        throw Exception(
            'Error fetching historical data: ${response.statusCode}');
      }

      final Map<String, dynamic> decodedData = json.decode(response.body);

      // Validar la estructura de la respuesta
      if (!decodedData.containsKey('serie')) {
        throw Exception('Invalid API response: missing serie field');
      }

      final serie = decodedData['serie'] as List;
      if (serie.isEmpty) {
        throw Exception('No historical data available');
      }

      // Asegurarse de que tenemos al menos dos valores para comparar
      double todayValue;
      double yesterdayValue;
      DateTime todayDate;
      DateTime yesterdayDate;

      // Procesar el valor de hoy
      try {
        todayValue = _extractValue(serie[0]['valor']);
        todayDate = DateTime.parse(serie[0]['fecha']);
      } catch (e) {
        _logger.e('Error processing today\'s value: $e');
        throw Exception('Error processing today\'s value');
      }

      // Procesar el valor de ayer
      try {
        if (serie.length > 1) {
          yesterdayValue = _extractValue(serie[1]['valor']);
          yesterdayDate = DateTime.parse(serie[1]['fecha']);
        } else {
          // Si solo hay un valor, usar el mismo para ambos
          yesterdayValue = todayValue;
          yesterdayDate = todayDate.subtract(const Duration(days: 1));
        }
      } catch (e) {
        _logger.e('Error processing yesterday\'s value: $e');
        throw Exception('Error processing yesterday\'s value');
      }

      final historicalData = HistoricalCurrencyData(
        todayValue: todayValue,
        yesterdayValue: yesterdayValue,
        todayDate: todayDate,
        yesterdayDate: yesterdayDate,
      );

      // Guardar en caché
      await _cacheManager.saveToCache(
        cacheKey,
        json.encode(historicalData.toJson()),
      );

      return historicalData;
    } catch (e) {
      // Intentar usar caché expirado en caso de error
      final cachedData = _cacheManager.getFromCache(cacheKey);
      if (cachedData != null) {
        _logger.w('Using expired historical cache due to API error: $e');
        try {
          return HistoricalCurrencyData.fromJson(json.decode(cachedData));
        } catch (cacheError) {
          _logger.e('Error processing cached data: $cacheError');
          throw Exception('Error processing historical data');
        }
      }
      _logger.e('Error fetching historical currency data: $e');
      throw Exception('Failed to fetch historical currency data');
    }
  }

  double _extractValue(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.parse(value);
    } else {
      throw Exception('Invalid value format');
    }
  }

  String calculatePercentageChange(HistoricalCurrencyData data) {
    try {
      if (data.yesterdayValue == 0) {
        return '+0.00%';
      }
      final change =
          ((data.todayValue - data.yesterdayValue) / data.yesterdayValue) * 100;
      final isPositive = change >= 0;
      return '${isPositive ? '+' : ''}${change.toStringAsFixed(2)}%';
    } catch (e) {
      _logger.e('Error calculating percentage change: $e');
      return '0.00%';
    }
  }

  Future<List<CurrencyViewModel>> _processData(String jsonData) async {
    try {
      final Map<String, dynamic> decodedData = json.decode(jsonData);
      final currencies = _parseCurrencies(decodedData);
      return _createViewModels(currencies);
    } catch (e) {
      _logger.e('Error al procesar datos: $e');
      throw Exception('Error al procesar datos: $e');
    }
  }

  List<Currency> _parseCurrencies(Map<String, dynamic> data) {
    final List<Currency> currencies = [];

    data.forEach((key, value) {
      if (value is Map<String, dynamic> && value.containsKey('codigo')) {
        try {
          currencies.add(Currency.fromJson(value));
        } catch (e) {
          _logger.w('Error al parsear divisa: $e');
        }
      }
    });

    return currencies;
  }

  List<CurrencyViewModel> _createViewModels(List<Currency> currencies) {
    return currencies.map((currency) {
      return CurrencyViewModel.fromCurrency(
        currency,
        titulo: ApiConstants.currencyNames[currency.codigo] ?? currency.codigo,
        icon: getIconForCurrency(currency.codigo),
      );
    }).toList();
  }

  Future<void> clearCache() async {
    await _cacheManager.clearCache();
  }

  void dispose() {
    _logger.d('Liberando recursos del ApiService');
  }
}
