import 'package:flutter/material.dart';
import 'package:greengrocer/src/configs/app_data.dart' as mock;
import 'package:greengrocer/src/pages/order/components/order_tile.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (ctx, index) => OrderTile(order: mock.orders[index]),
        separatorBuilder: (_, index) => const SizedBox(height: 8.0),
        itemCount: mock.orders.length,
      ),
    );
  }
}
