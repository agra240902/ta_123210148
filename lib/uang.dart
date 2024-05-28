import 'package:flutter/material.dart';

class UangPage extends StatefulWidget {
  @override
  _UangPageState createState() => _UangPageState();
}

class _UangPageState extends State<UangPage> {
  final TextEditingController _controller = TextEditingController();

  // Nilai tukar konversi ke berbagai mata uang
  final double _conversionRateUSD = 0.000071;
  final double _conversionRateEUR = 0.000059;
  final double _conversionRatePHP = 0.0038;
  final double _conversionRateCNY = 0.00051;
  final double _conversionRateMYR = 0.00029;

  double _convertedValueUSD = 0.0;
  double _convertedValueEUR = 0.0;
  double _convertedValuePHP = 0.0;
  double _convertedValueCNY = 0.0;
  double _convertedValueMYR = 0.0;

  void _convertCurrency() {
    setState(() {
      double input = double.tryParse(_controller.text) ?? 0.0;
      _convertedValueUSD = input * _conversionRateUSD;
      _convertedValueEUR = input * _conversionRateEUR;
      _convertedValuePHP = input * _conversionRatePHP;
      _convertedValueCNY = input * _conversionRateCNY;
      _convertedValueMYR = input * _conversionRateMYR;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> conversionResults = [
      {'currency': 'USD', 'symbol': '\$', 'value': _convertedValueUSD},
      {'currency': 'EUR', 'symbol': '€', 'value': _convertedValueEUR},
      {'currency': 'PHP', 'symbol': '₱', 'value': _convertedValuePHP},
      {'currency': 'CNY', 'symbol': '¥', 'value': _convertedValueCNY},
      {'currency': 'MYR', 'symbol': 'RM', 'value': _convertedValueMYR},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Mata Uang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Masukkan jumlah dalam Rupiah:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Rupiah',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: Text('Konversi'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hasil konversi:',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: conversionResults.length,
                itemBuilder: (context, index) {
                  final result = conversionResults[index];
                  return ListTile(
                    title: Text(
                      '${result['currency']}: ${result['symbol']}${result['value'].toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Aplikasi Konversi Mata Uang',
    home: UangPage(),
  ));
}
