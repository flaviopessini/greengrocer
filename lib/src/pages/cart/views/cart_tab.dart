import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/configs/app_data.dart' as mock;
import 'package:greengrocer/src/configs/custom_colors.dart';
import 'package:greengrocer/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocer/src/pages/cart/views/components/cart_tile.dart';
import 'package:greengrocer/src/pages/common_widgets/payment_dialog.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GetBuilder<CartController>(
              builder: (ctrl) => ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: ctrl.cartItems.length,
                itemBuilder: (ctx, index) => CartTile(
                  cartItem: ctrl.cartItems[index],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Text(
                      'Total do carrinho: ',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    GetBuilder<CartController>(
                      builder: (ctrl) => Text(
                        UtilsServices.priceToCurrency(ctrl.cartTotalPrice()),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwatchColor,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 48.0,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();

                      if (result ?? false) {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              PaymentDialog(order: mock.orders.first),
                        );
                      } else {
                        UtilsServices.showToast(
                          message: 'Pedido não confirmado',
                          isError: true,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      backgroundColor: CustomColors.customSwatchColor,
                    ),
                    icon: const Icon(Icons.shopping_cart_checkout_rounded),
                    label: Text(
                      'finalizar pedido',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          alignment: Alignment.center,
          elevation: 5,
          title: const Text('Confirmação'),
          content: const Text('Deseja concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                backgroundColor: CustomColors.customSwatchColor,
              ),
              child: const Text('Sim'),
            )
          ],
        );
      },
    );
  }
}
