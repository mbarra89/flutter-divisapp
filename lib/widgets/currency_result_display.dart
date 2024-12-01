import 'package:divisapp/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ConversionResultDisplay extends StatelessWidget {
  final String conversionResult;

  const ConversionResultDisplay({
    super.key,
    required this.conversionResult,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppTheme.neutralTextColor,
                    ),
                children: [
                  TextSpan(
                    text: conversionResult.isEmpty ? '0.00' : conversionResult,
                    style: const TextStyle(
                      color: AppTheme.actionButtonTextColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.neutralTextColor,
                    ),
                children: const [
                  TextSpan(
                    text: 'Valor aproximado',
                    style: TextStyle(
                      color: AppTheme.neutralTextColor,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
