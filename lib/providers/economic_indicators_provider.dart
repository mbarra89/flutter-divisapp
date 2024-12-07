import 'package:divisapp/models/economic_indicators_model.dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'economic_indicators_provider.g.dart';

class EconomicIndicatorsDatabase {
  static final Logger _logger = Logger();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'economic_indicators.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IndicadoresEconomicos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        codigo TEXT NOT NULL UNIQUE,
        nombre TEXT NOT NULL,
        descripcion TEXT NOT NULL
      )
    ''');
  }

  Future<bool> isDatabasePopulated() async {
    final db = await database;
    final count = Sqflite.firstIntValue(
        await db.query('IndicadoresEconomicos', columns: ['COUNT(*)']));
    return count != null && count > 0;
  }

  Future<void> insertInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = prefs.getBool('first_run_economic_indicators') ?? true;

    if (isFirstRun) {
      final db = await database;
      final indicadores = [
        EconomicIndicatorModel(
          codigo: 'uf',
          nombre: 'Unidad de Fomento (UF)',
          descripcion:
              'Unidad de cuenta reajustable según la inflación en Chile.',
        ),
        EconomicIndicatorModel(
          codigo: 'ivp',
          nombre: 'Índice de Valor Promedio (IVP)',
          descripcion:
              'Mide la variación diaria del valor promedio de las UF en un período determinado.',
        ),
        EconomicIndicatorModel(
          codigo: 'dolar',
          nombre: 'Dólar Observado',
          descripcion:
              'Valor oficial del dólar en el mercado chileno, fijado por el Banco Central.',
        ),
        EconomicIndicatorModel(
          codigo: 'dolar_intercambio',
          nombre: 'Dólar Intercambio',
          descripcion:
              'Tipo de cambio del dólar usado en transacciones entre bancos o casas de cambio.',
        ),
        EconomicIndicatorModel(
          codigo: 'euro',
          nombre: 'Euro',
          descripcion:
              'Moneda oficial de la Eurozona, utilizada como referencia para transacciones internacionales en Chile.',
        ),
        EconomicIndicatorModel(
          codigo: 'ipc',
          nombre: 'Índice de Precios al Consumidor (IPC)',
          descripcion:
              'Mide la variación de precios de una canasta de bienes y servicios representativa del consumo.',
        ),
        EconomicIndicatorModel(
          codigo: 'utm',
          nombre: 'Unidad Tributaria Mensual (UTM)',
          descripcion:
              'Valor usado para el cálculo de impuestos, multas y otros pagos tributarios.',
        ),
        EconomicIndicatorModel(
          codigo: 'imacec',
          nombre: 'Índice Mensual de Actividad Económica (IMACEC)',
          descripcion:
              'Indicador que mide la evolución de la economía chilena a corto plazo.',
        ),
        EconomicIndicatorModel(
          codigo: 'tpm',
          nombre: 'Tasa de Política Monetaria (TPM)',
          descripcion:
              'Tasa de interés fijada por el Banco Central para influir en la inflación y la economía.',
        ),
        EconomicIndicatorModel(
          codigo: 'libra_cobre',
          nombre: 'Precio de la Libra de Cobre',
          descripcion:
              'Valor internacional del cobre, principal exportación de Chile.',
        ),
        EconomicIndicatorModel(
          codigo: 'tasa_desempleo',
          nombre: 'Tasa de Desempleo',
          descripcion:
              'Porcentaje de la población económicamente activa que está desempleada.',
        ),
        EconomicIndicatorModel(
          codigo: 'bitcoin',
          nombre: 'Bitcoin',
          descripcion:
              'Criptomoneda descentralizada y referencia en el mercado de criptomonedas.',
        ),
      ];

      for (var indicador in indicadores) {
        await db.insert(
            'IndicadoresEconomicos',
            {
              'codigo': indicador.codigo,
              'nombre': indicador.nombre,
              'descripcion': indicador.descripcion
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      // Marca que ya no es la primera ejecución
      await prefs.setBool('first_run_economic_indicators', false);
      _logger.i('Initial economic indicators inserted');
    }
  }

  Future<List<EconomicIndicatorModel>> getIndicadores() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('IndicadoresEconomicos');

    return List.generate(maps.length, (i) {
      return EconomicIndicatorModel(
        id: maps[i]['id'],
        codigo: maps[i]['codigo'],
        nombre: maps[i]['nombre'],
        descripcion: maps[i]['descripcion'],
      );
    });
  }

  Future<EconomicIndicatorModel?> getIndicadorByCodigo(String codigo) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
        'IndicadoresEconomicos',
        where: 'codigo = ?',
        whereArgs: [codigo]);

    if (maps.isNotEmpty) {
      return EconomicIndicatorModel(
        id: maps[0]['id'],
        codigo: maps[0]['codigo'],
        nombre: maps[0]['nombre'],
        descripcion: maps[0]['descripcion'],
      );
    }
    return null;
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

@riverpod
EconomicIndicatorsDatabase economicIndicatorsDatabase(Ref ref) {
  return EconomicIndicatorsDatabase();
}

@riverpod
Future<void> initializeEconomicIndicators(Ref ref) async {
  final database = ref.watch(economicIndicatorsDatabaseProvider);

  try {
    await database.insertInitialData();
  } catch (e) {
    Logger().e('Error initializing economic indicators: $e');
    throw Exception('Failed to initialize economic indicators');
  }
}

@riverpod
Future<List<EconomicIndicatorModel>> economicIndicators(Ref ref) async {
  final database = ref.watch(economicIndicatorsDatabaseProvider);

  try {
    final indicators = await database.getIndicadores();
    Logger().i('Loaded ${indicators.length} economic indicators');
    return indicators;
  } catch (e) {
    Logger().e('Error loading economic indicators: $e');
    throw Exception('Failed to load economic indicators');
  }
}

@riverpod
Future<EconomicIndicatorModel?> economicIndicatorByCodigo(
    Ref ref, String codigo) async {
  final database = ref.watch(economicIndicatorsDatabaseProvider);

  try {
    final indicator = await database.getIndicadorByCodigo(codigo);
    if (indicator != null) {
      Logger().i('Retrieved indicator: ${indicator.nombre}');
    } else {
      Logger().w('No indicator found for code: $codigo');
    }
    return indicator;
  } catch (e) {
    Logger().e('Error retrieving indicator for code $codigo: $e');
    throw Exception('Failed to retrieve economic indicator');
  }
}
