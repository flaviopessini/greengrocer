import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/order/controller/all_order_controller.dart';
import 'package:greengrocer/src/pages/order/views/components/order_tile.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: GetBuilder<AllOrderController>(
        builder: (ctrl) =>
            RefreshIndicator(
              onRefresh: () => ctrl.getAllOrders(),
              child: ListView.separated(
                padding: const EdgeInsets.all(16.0),
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (_, index) =>
                    OrderTile(order: ctrl.allOrders[index]),
                separatorBuilder: (_, index) => const SizedBox(height: 8.0),
                itemCount: ctrl.allOrders.length,
              ),
            ),
      ),
    );
  }
}
