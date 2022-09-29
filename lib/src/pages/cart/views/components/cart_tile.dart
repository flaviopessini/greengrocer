import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/configs/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocer/src/pages/common_widgets/quantity_widget.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CartTile extends StatefulWidget {
  final CartItemModel cartItem;

  const CartTile({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        leading: Image.network(
          widget.cartItem.item.imgUrl,
          height: 72.0,
          width: 72.0,
        ),
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          UtilsServices.priceToCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: QuantityWidget(
          value: widget.cartItem.quantity,
          suffixText: widget.cartItem.item.unit,
          isRemovable: true,
          result: (int quantity) {
            cartController.changeItemQuantity(item: widget.cartItem, quantity: quantity);
          },
        ),
      ),
    );
  }
}
