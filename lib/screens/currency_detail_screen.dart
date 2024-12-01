import 'package:divisapp/models/currency_view_model.dart';
import 'package:divisapp/providers/historical_provider.dart';
import 'package:divisapp/router.dart';
import 'package:divisapp/theme/app_theme.dart';
import 'package:divisapp/utils/currency_formatter.dart';
import 'package:divisapp/widgets/currency_graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CurrencyDetailScreen extends ConsumerWidget {
  final CurrencyViewModel currency;

  const CurrencyDetailScreen({super.key, required this.currency});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historicalData = ref.watch(historicalSeriesProvider(currency.codigo));
    final minValue = ref
        .read(historicalSeriesProvider(currency.codigo).notifier)
        .getMinValue();
    final maxValue = ref
        .read(historicalSeriesProvider(currency.codigo).notifier)
        .getMaxValue();

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
                  onPressed: () => _showCurrencyInfoDialog(context),
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
                  _buildImprovedStatsGrid(minValue, maxValue),

                  const SizedBox(height: 16),

                  // Historical Statistics Access
                  _buildHistoricalStatsButton(context),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading data: ${error.toString()}'),
        ),
      ),
    );
  }

  Widget _buildImprovedStatsGrid(double minValue, double maxValue) {
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
            _buildStatItem(MdiIcons.minus, 'Mediana', 'colocar valor mediana'),
            _buildStatItem(
                MdiIcons.chartLine, 'Promedio', 'colocar valor promedio'),
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

  Widget _buildHistoricalStatsButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: Implement navigation to historical stats screen
        },
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

  void _showCurrencyInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Qué es la Unidad de Fomento?'),
          content: const Text(
            'La Unidad de Fomento (UF) es una unidad de cuenta reajustable que se usa en Chile. '
            'Su valor se ajusta diariamente según la inflación para mantener el poder adquisitivo constante.',
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
  }
}
