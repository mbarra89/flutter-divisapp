import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:divisapp/services/api_service.dart';

class HistoricalSeriesData {
  final String version;
  final String autor;
  final String codigo;
  final String nombre;
  final String unidadMedida;
  final List<SerieEntry> serie;

  HistoricalSeriesData({
    required this.version,
    required this.autor,
    required this.codigo,
    required this.nombre,
    required this.unidadMedida,
    required this.serie,
  });

  Map<String, dynamic> toJson() => {
        'version': version,
        'autor': autor,
        'codigo': codigo,
        'nombre': nombre,
        'unidad_medida': unidadMedida,
        'serie': serie.map((entry) => entry.toJson()).toList(),
      };

  factory HistoricalSeriesData.fromJson(Map<String, dynamic> json) {
    return HistoricalSeriesData(
      version: json['version'] as String,
      autor: json['autor'] as String,
      codigo: json['codigo'] as String,
      nombre: json['nombre'] as String,
      unidadMedida: json['unidad_medida'] as String,
      serie: (json['serie'] as List)
          .map((entry) => SerieEntry.fromJson(entry))
          .toList(),
    );
  }
}

class SerieEntry {
  final DateTime fecha;
  final double valor;

  SerieEntry({
    required this.fecha,
    required this.valor,
  });

  Map<String, dynamic> toJson() => {
        'fecha': fecha.toIso8601String(),
        'valor': valor,
      };

  factory SerieEntry.fromJson(Map<String, dynamic> json) {
    return SerieEntry(
      fecha: DateTime.parse(json['fecha'] as String),
      valor: _parseValue(json['valor']),
    );
  }

  static double _parseValue(dynamic value) {
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.parse(value);
    throw Exception('Invalid value format');
  }
}

class HistoricalService {
  final Logger _logger;
  final http.Client _client;
  final CacheManager _cacheManager;
  static const String _historicalCacheKeyPrefix = 'historical_series_';

  HistoricalService({
    required http.Client client,
    required SharedPreferences prefs,
  })  : _logger = Logger(),
        _client = client,
        _cacheManager = CacheManager(prefs);

  Future<HistoricalSeriesData> getHistoricalSeries(String currencyCode) async {
    final cacheKey = '$_historicalCacheKeyPrefix$currencyCode';

    try {
      // Try cache first
      if (_cacheManager.isCacheValid(cacheKey)) {
        final cachedData = _cacheManager.getFromCache(cacheKey);
        if (cachedData != null) {
          _logger.d('Using cached historical series data for $currencyCode');
          return HistoricalSeriesData.fromJson(json.decode(cachedData));
        }
      }

      // Fetch from API if no valid cache
      _logger.d('Fetching fresh historical series data for $currencyCode');
      final uri = Uri.parse('${ApiConstants.baseUrl}/$currencyCode');
      final response = await _client.get(uri);

      if (response.statusCode != 200) {
        throw Exception(
            'Error fetching historical series data: ${response.statusCode}');
      }

      final decodedData = json.decode(response.body);
      final historicalData = HistoricalSeriesData.fromJson(decodedData);

      // Save to cache
      await _cacheManager.saveToCache(
        cacheKey,
        json.encode(historicalData.toJson()),
      );

      return historicalData;
    } catch (e) {
      // Try expired cache in case of error
      final cachedData = _cacheManager.getFromCache(cacheKey);
      if (cachedData != null) {
        _logger.w('Using expired historical series cache due to API error: $e');
        try {
          return HistoricalSeriesData.fromJson(json.decode(cachedData));
        } catch (cacheError) {
          _logger.e('Error processing cached series data: $cacheError');
          throw Exception('Error processing historical series data');
        }
      }
      _logger.e('Error fetching historical series data: $e');
      throw Exception('Failed to fetch historical series data');
    }
  }

  Map<String, dynamic> calculateHistoricalStats(HistoricalSeriesData data) {
    try {
      final values = data.serie.map((entry) => entry.valor).toList();
      values.sort();

      final avg = values.reduce((a, b) => a + b) / values.length;
      final min = values.first;
      final max = values.last;

      final median = values.length % 2 == 0
          ? (values[values.length ~/ 2 - 1] + values[values.length ~/ 2]) / 2
          : values[values.length ~/ 2];

      return {
        'average': avg,
        'median': median,
        'minimum': min,
        'maximum': max,
        'totalEntries': values.length,
        'dateRange': {
          'from': data.serie.last.fecha,
          'to': data.serie.first.fecha,
        },
      };
    } catch (e) {
      _logger.e('Error calculating historical stats: $e');
      throw Exception('Error calculating historical statistics');
    }
  }
}
