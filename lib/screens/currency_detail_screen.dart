import 'dart:io';

import 'package:divisapp/models/currency_view_model.dart';
import 'package:divisapp/providers/economic_indicators_provider.dart';
import 'package:divisapp/providers/historical_provider.dart';
import 'package:divisapp/router.dart';
import 'package:divisapp/theme/app_theme.dart';
import 'package:divisapp/utils/currency_formatter.dart';
import 'package:divisapp/widgets/currency_graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class CurrencyDetailScreen extends ConsumerWidget {
  final CurrencyViewModel currency;
  late final Logger _logger;

  CurrencyDetailScreen({super.key, required this.currency}) {
    // Initialize the logger
    _logger = Logger(
      printer: PrettyPrinter(),
      filter: ProductionFilter(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historicalData = ref.watch(historicalSeriesProvider(currency.codigo));
    final minValue = ref
        .read(historicalSeriesProvider(currency.codigo).notifier)
        .getMinValue();
    final maxValue = ref
        .read(historicalSeriesProvider(currency.codigo).notifier)
        .getMaxValue();

    final median = ref
        .read(historicalSeriesProvider(currency.codigo).notifier)
        .getMedianValue();
    final average = ref
        .read(historicalSeriesProvider(currency.codigo).notifier)
        .getAverageValue();

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: AppTheme.iconBackgroundColor,
                  borderRadius: BorderRadius.circular(8)),
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => context.go(AppRoute.home.path),
                  icon: const Icon(Icons.arrow_back)),
            ),
          ),
        ),
        title: Text(currency.nombre,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: AppTheme.iconBackgroundColor,
                    borderRadius: BorderRadius.circular(8)),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => _showCurrencyInfoDialog(context, ref),
                  icon: const Icon(Icons.info_outline),
                ),
              ),
            ),
          )
        ],
      ),
      body: historicalData.when(
        data: (data) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Graph Widget
                  Card(
                    color: AppTheme.darkSurfaceColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CurrencyGraphWidget(
                          series: data.series, currency: currency),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Stats grid with improved design
                  _buildImprovedStatsGrid(minValue, maxValue, median, average),

                  const SizedBox(height: 16),

                  // Historical Statistics Access
                  _buildHistoricalStatsButton(context, data.series),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          _logger.e('Error loading data: $error');
          _logger.e('Stack trace: $stack');
          return Center(
            child: Text('Error loading data: $error'),
          );
        },
      ),
    );
  }

  Future<void> _sendCsvByEmail(
      BuildContext context, List<dynamic> series) async {
    try {
      // Prepare CSV content
      StringBuffer csvBuffer = StringBuffer();
      csvBuffer.writeln('Fecha,Valor');

      for (var dataPoint in series) {
        csvBuffer.writeln('${dataPoint.fecha},${dataPoint.valor}');
      }

      // Create a temporary file with the CSV data
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/${currency.nombre}_historial.csv');
      await file.writeAsString(csvBuffer.toString());

      // Open the email app with the attachment
      final result = await OpenFile.open(file.path);
      if (result.type == ResultType.done) {
        // Email app opened successfully
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reporte enviado por correo')),
          );
        }
      } else {
        // Error opening the email app
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al enviar el reporte')),
          );
        }
      }
    } catch (e, stack) {
      // Handle potential errors
      _logger.e('Error sending CSV by email: $e');
      _logger.e('Stack trace: $stack');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al enviar el reporte: $e')),
        );
      }
    }
  }

  Widget _buildHistoricalStatsButton(
      BuildContext context, List<dynamic> series) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => _sendCsvByEmail(context, series),
        icon: const Icon(Icons.download_rounded),
        label: const Text('Descargar reporte'),
        style: ElevatedButton.styleFrom(
          foregroundColor: AppTheme.accentButtonTextColor,
          backgroundColor: AppTheme.accentGoldColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildImprovedStatsGrid(
      double minValue, double maxValue, double median, double average) {
    return Card(
      color: AppTheme.darkSurfaceColor,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: 2.5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildStatItem(MdiIcons.arrowDownBold, 'Valor mínimo',
                CurrencyFormatter.formatRate(minValue, currency.unidadMedida)),
            _buildStatItem(MdiIcons.arrowUpBold, 'Valor máximo',
                CurrencyFormatter.formatRate(maxValue, currency.unidadMedida)),
            _buildStatItem(MdiIcons.minus, 'Mediana',
                CurrencyFormatter.formatRate(median, currency.unidadMedida)),
            _buildStatItem(MdiIcons.chartLine, 'Promedio',
                CurrencyFormatter.formatRate(average, currency.unidadMedida)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showCurrencyInfoDialog(BuildContext context, WidgetRef ref) async {
    try {
      // Fetch the economic indicator based on the currency code
      final indicator = await ref
          .read(economicIndicatorsDatabaseProvider)
          .getIndicadorByCodigo(currency.codigo);

      if (indicator != null) {
        // Show dialog with the description from the database
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('¿Qué es el ${indicator.nombre}?'),
              content: Text(
                indicator.descripcion,
                style: const TextStyle(height: 1.5),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cerrar'),
                ),
              ],
            );
          },
        );
      } else {
        // Fallback if no indicator is found
        // ignore: use_build_context_synchronously
        _showDefaultInfoDialog(context);
      }
    } catch (e) {
      // Error handling
      // ignore: use_build_context_synchronously
      _showDefaultInfoDialog(context);
    }
  }

  void _showDefaultInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Información de Moneda'),
          content: const Text(
            'No se pudo obtener la información detallada en este momento.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.buttonTextColor,
              ),
              child: const Text('Cerrar',
                  style:
                      TextStyle(color: AppTheme.buttonTextColor, fontSize: 16)),
            ),
          ],
        );
      },
    );
  }
}
