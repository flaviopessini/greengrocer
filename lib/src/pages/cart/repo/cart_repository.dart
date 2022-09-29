import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems({
    required String token,
    required String userId,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'user': userId,
      },
    );
    if (result['result'] != null) {
      final cartItems = List<Map<String, dynamic>>.from(result['result'])
          .map((e) => CartItemModel.fromJson(e))
          .toList();
      return CartResult<List<CartItemModel>>.success(cartItems);
    } else {
      return CartResult.error('Falha ao obter os itens do carrinho');
    }
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.addItemToCart,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'user': userId,
        'quantity': quantity,
        'productId': productId,
      },
    );
    if (result['result'] != null) {
      return CartResult<String>.success(result['result']['id']);
    } else {
      return CartResult.error('Falha ao adicionar item no carrinho');
    }
  }

  Future<bool> changeItemQuantity({
    required String cartItemId,
    required int quantity,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.changeItemQuantity,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'cartItemId': cartItemId,
        'quantity': quantity,
      },
    );
    return result != null;
  }

  Future<CartResult<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.checkout,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'total': total,
      },
    );
    if (result['result'] != null) {
      final order = OrderModel.fromJson(result['result']);
      return CartResult<OrderModel>.success(order);
    } else {
      return CartResult.error('Erro ao finalizar o pedido');
    }
  }
}
