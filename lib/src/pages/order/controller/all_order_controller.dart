import 'package:get/get.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/auth/controllers/auth_controller.dart';
import 'package:greengrocer/src/pages/order/repo/order_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AllOrderController extends GetxController {
  final orderRepository = OrderRepository();
  final authController = Get.find<AuthController>();

  List<OrderModel> allOrders = [];

  @override
  void onInit(){
    super.onInit();

    getAllOrders();
  }

  Future<void> getAllOrders() async {
    final result = await orderRepository.getAllOrders(
      userId: authController.user.id!,
      token: authController.user.token!,
    );
    result.when(
      success: (orders) {
        allOrders.assignAll(orders);
        update();
      },
      error: (message) {
        UtilsServices.showToast(message: message);
      },
    );
  }
}
