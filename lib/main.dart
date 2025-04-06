import 'package:flutter/material.dart';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'محول العملات',
      debugShowCheckedModeBanner: false,
      home: CurrencyHomePage(),
    );
  }
}

class CurrencyHomePage extends StatefulWidget {
  @override
  _CurrencyHomePageState createState() => _CurrencyHomePageState();
}

class _CurrencyHomePageState extends State<CurrencyHomePage> {
  String fromCurrency = 'USD';
  String toCurrency = 'EGP';
  double amount = 0.0;
  double result = 0.0;

  final TextEditingController _controller = TextEditingController();

  final Map<String, double> rates = {
    'USD': 1.0,      // الدولار الأمريكي
    'EUR': 0.91,     // اليورو
    'EGP': 50.58,     // الجنيه المصري
    'SAR': 3.75,     // الريال السعودي
    'AED': 3.67      // الدرهم الإماراتي
  };

  void convert() {
    double rateFrom = rates[fromCurrency]!;
    double rateTo = rates[toCurrency]!;

    setState(() {
      result = (amount / rateFrom) * rateTo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' محول العملات')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ادخل المبلغ',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                amount = double.tryParse(value) ?? 0.0;
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: fromCurrency,
                    isExpanded: true,
                    items: rates.keys
                        .map((code) => DropdownMenuItem(
                              child: Text(code),
                              value: code,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        fromCurrency = value!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 20),
                Icon(Icons.arrow_forward),
                SizedBox(width: 20),
                Expanded(
                  child: DropdownButton<String>(
                    value: toCurrency,
                    isExpanded: true,
                    items: rates.keys
                        .map((code) => DropdownMenuItem(
                              child: Text(code),
                              value: code,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        toCurrency = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: convert,
              child: Text('تحويل'),
            ),
            SizedBox(height: 20),
            Text(
              'النتيجة: ${result.toStringAsFixed(2)} $toCurrency',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
