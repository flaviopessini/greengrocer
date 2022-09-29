import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/auth/controllers/auth_controller.dart';
import 'package:greengrocer/src/pages/cart/repo/cart_repository.dart';
import 'package:greengrocer/src/pages/common_widgets/payment_dialog.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();

  bool isCheckoutLoading = false;

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((element) => element.item.id == item.id);
  }

  void setCheckoutLoading(bool loading) {
    isCheckoutLoading = loading;
    update();
  }

  double cartTotalPrice() {
    double total = 0;
    for (final i in cartItems) {
      total += i.totalPrice();
    }
    return total;
  }

  // Retorna a quantidade total unitária de itens no carrinho.
  int getCartTotalItems() {
    // Mapear a lista de itens do carrinho e criar uma nova lista contendo
    // a quantidade de cada item do carrinho. Com o 'reduce' somamos todas as
    // quantidades e retornamos o resultado.
    return cartItems.isEmpty
        ? 0
        : cartItems.map((e) => e.quantity).reduce((a, b) => a + b);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int index = getItemIndex(item);
    if (index >= 0) {
      // Já existe na lista
      final product = cartItems[index];
      await changeItemQuantity(
        item: product,
        quantity: (product.quantity + quantity),
      );
    } else {
      final result = await cartRepository.addItemToCart(
        userId: authController.user.id!,
        token: authController.user.token!,
        productId: item.id,
        quantity: quantity,
      );
      result.when(
        success: (cartItemId) {
          cartItems.add(CartItemModel(
            item: item,
            id: cartItemId,
            quantity: quantity,
          ));
        },
        error: (message) {
          UtilsServices.showToast(message: message, isError: true);
        },
      );
    }

    update();
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await cartRepository.changeItemQuantity(
      cartItemId: item.id,
      quantity: quantity,
      token: authController.user.token!,
    );
    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere((element) => element.id == item.id);
      } else {
        cartItems.firstWhere((element) => element.id == item.id).quantity =
            quantity;
      }

      update();
    } else {
      UtilsServices.showToast(
          message: 'Ocorreu um erro ao alterar a quantidade do produto',
          isError: true);
    }
    return result;
  }

  Future<void> getCartItems() async {
    final result = await cartRepository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
      success: (data) {
        cartItems.assignAll(data);
        update();
      },
      error: (message) {
        UtilsServices.showToast(message: message, isError: true);
      },
    );
  }

  Future checkoutCart() async {
    setCheckoutLoading(true);
    final result = await cartRepository.checkoutCart(
      token: authController.user.token!,
      total: cartTotalPrice(),
    );
    setCheckoutLoading(false);
    result.when(
      success: (data) {
        cartItems.clear();
        update();
        showDialog(
          context: Get.context!,
          builder: (_) => PaymentDialog(order: data),
        );
      },
      error: (message) {
        UtilsServices.showToast(message: message, isError: true);
      },
    );
  }
}
