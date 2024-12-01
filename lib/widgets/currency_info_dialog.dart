import 'package:flutter/material.dart';

class CurrencyInfoDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Información'),
          content: const Text('Aquí se mostrará información sobre la moneda'),
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
