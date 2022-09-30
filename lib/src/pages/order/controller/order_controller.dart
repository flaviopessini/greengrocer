import 'package:get/get.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/auth/controllers/auth_controller.dart';
import 'package:greengrocer/src/pages/order/repo/order_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class OrderController extends GetxController {
  final orderRepository = OrderRepository();
  final authController = Get.find<AuthController>();

  OrderModel order;

  bool isLoading = false;

  OrderController(this.order);

  void setLoading(bool value){
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    setLoading(true);
    final result = await orderRepository.getOrderItems(
      token: authController.user.token!,
      orderId: order.id,
    );
    setLoading(false);
    result.when(
      success: (items) {
        order.items.assignAll(items);
        update();
      },
      error: (message) {
        UtilsServices.showToast(message: message, isError: true);
      },
    );
  }
}
