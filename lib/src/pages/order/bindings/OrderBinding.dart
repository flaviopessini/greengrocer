import 'package:get/get.dart';
import 'package:greengrocer/src/pages/order/controller/all_order_controller.dart';

class OrderBinding with Bindings {

  @override
  void dependencies() {
    Get.put(AllOrderController());
  }
}
