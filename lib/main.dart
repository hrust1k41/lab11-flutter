import 'package:flutter/material.dart';

Future<String> getUser() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Anna';
}

Future<String> getProducts() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Phone, Laptop, Headphones';
}

Future<String> getOrders() async {
  await Future.delayed(const Duration(seconds: 3));
  return 'Order #1, Order #2';
}

void main() {
  runApp(const MaterialApp(home: ShopScreen()));
}

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<String> _results = [];
  String _error = '';

  Future<void> _load() async {
    try {
      final results = await Future.wait([getUser(), getProducts(), getOrders()]);
      setState(() {
        _results = results;
        _error = '';
      });
    } catch (e) {
      setState(() {
        _results = [];
        _error = 'Помилка: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Online shop')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(onPressed: _load, child: const Text('Load')),
            if (_error.isNotEmpty) Text(_error),
            if (_results.isNotEmpty) ...[
              Text('User: ${_results[0]}'),
              Text('Products: ${_results[1]}'),
              Text('Orders: ${_results[2]}'),
            ],
          ],
        ),
      ),
    );
  }
}