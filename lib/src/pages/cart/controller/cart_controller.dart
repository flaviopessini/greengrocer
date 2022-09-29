import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/auth/controllers/auth_controller.dart';
import 'package:greengrocer/src/pages/cart/repo/cart_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((element) => element.item.id == item.id);
  }

  double cartTotalPrice() {
    double total = 0;
    for (final i in cartItems) {
      total += i.totalPrice();
    }
    return total;
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int index = getItemIndex(item);
    if (index >= 0) {
      // Já existe na lista
      final product = cartItems[index];
      final result = await changeItemQuantity(
        item: product,
        quantity: (product.quantity + quantity),
      );
      if (result) {
        cartItems[index].quantity += quantity;
      } else {
        UtilsServices.showToast(
            message: 'Ocorreu um erro ao alterar a quantidade do produto',
            isError: true);
      }
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
}
