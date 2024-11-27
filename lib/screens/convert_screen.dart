import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConvertScreen extends StatefulWidget {
  const ConvertScreen({super.key});

  @override
  _ConvertScreenState createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  final TextEditingController _amountController = TextEditingController();
  double _convertedAmount = 0.0;
  String _selectedCurrency = 'UF';

  // Aquí podrías reemplazar con tasas de cambio reales o llamadas a una API
  final Map<String, double> _exchangeRates = {
    'UF': 37000.0, // Valor referencial de UF
    'USD': 0.0012, // Dólar
    'EUR': 0.0011, // Euro
    'BTC': 0.000000026 // Bitcoin
  };

  void _convertCurrency() {
    if (_amountController.text.isEmpty) return;

    final inputValue = double.tryParse(_amountController.text) ?? 0.0;
    setState(() {
      switch (_selectedCurrency) {
        case 'UF':
          _convertedAmount = inputValue;
          break;
        case 'USD':
          _convertedAmount = inputValue * _exchangeRates['USD']!;
          break;
        case 'EUR':
          _convertedAmount = inputValue * _exchangeRates['EUR']!;
          break;
        case 'BTC':
          _convertedAmount = inputValue * _exchangeRates['BTC']!;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Convertidor de Moneda',
            style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Ingrese monto',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixText: 'CLP',
              ),
              onChanged: (_) => _convertCurrency(),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCurrency,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: ['UF', 'USD', 'EUR', 'BTC']
                        .map((currency) => DropdownMenuItem(
                              value: currency,
                              child: Text(currency),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCurrency = value!;
                        _convertCurrency();
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _convertCurrency,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Convertir',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resultado:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_amountController.text.isNotEmpty ? _amountController.text : '0'} CLP',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          '${_convertedAmount.toStringAsFixed(2)} $_selectedCurrency',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
