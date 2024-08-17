import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(ExchangeRateApp());
}

class ExchangeRateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exchange Rate',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: ExchangeRatePage(),
    );
  }
}

class ExchangeRatePage extends StatefulWidget {
  @override
  _ExchangeRatePageState createState() => _ExchangeRatePageState();
}

class _ExchangeRatePageState extends State<ExchangeRatePage> {
  double? _exchangeRate;

  @override
  void initState() {
    super.initState();
    _fetchExchangeRate();
  }

  Future<void> _fetchExchangeRate() async {
    final url = Uri.parse('https://api.exchangerate-api.com/v4/latest/USD');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _exchangeRate = data['rates']['IQD'];
      });
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('سعر الدينار امام الدولار ')),
      ),
      body: Center(
        child: _exchangeRate != null
            ? Text(
                '1 USD = $_exchangeRate IQD',
                style: const TextStyle(fontSize: 24),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
