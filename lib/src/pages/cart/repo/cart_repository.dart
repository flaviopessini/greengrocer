import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
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
}
