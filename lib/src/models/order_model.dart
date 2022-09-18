import 'package:greengrocer/src/models/cart_item_model.dart';

class OrderModel {
  String id;

  DateTime createdDateTime;

  List<CartItemModel> items;

  DateTime overdueDateTime;

  String copyAndPaste;

  String status;

  double total;

  OrderModel({
    required this.id,
    required this.createdDateTime,
    required this.items,
    required this.overdueDateTime,
    required this.copyAndPaste,
    required this.status,
    required this.total,
  });
}
