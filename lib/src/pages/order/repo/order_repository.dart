import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/order/order_result/order_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class OrderRepository {
  final _httpManager = HttpManager();

  Future<OrderResult<List<OrderModel>>> getAllOrders({
    required String userId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllOrders,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'user': userId,
      },
    );
    if (result['result'] != null) {
      final orders = List.from(result['result'])
          .map((e) => OrderModel.fromJson(e))
          .toList();
      return OrderResult<List<OrderModel>>.success(orders);
    } else {
      return OrderResult.error('Não foi possível carregar os pedidos');
    }
  }

  Future<OrderResult<List<CartItemModel>>> getOrderItems({
    required String token,
    required String orderId,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getOrderItems,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'orderId': orderId,
      },
    );
    if (result['result'] != null) {
      final items = List<Map<String, dynamic>>.from(result['result'])
          .map((e) => CartItemModel.fromJson(e))
          .toList();

      return OrderResult<List<CartItemModel>>.success(items);
    } else {
      return OrderResult.error(
          'Não foi possível recuperar a lista de itens do pedido');
    }
  }
}
