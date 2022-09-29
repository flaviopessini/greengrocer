import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;

  @JsonKey(name: 'createdAt')
  DateTime? createdDateTime;

  @JsonKey(defaultValue: [])
  List<CartItemModel> items;

  @JsonKey(name: 'due')
  DateTime overdueDateTime;

  @JsonKey(name: 'copiaecola')
  String copyAndPaste;

  String qrCodeImage;

  String status;

  double total;

  OrderModel({
    required this.id,
    required this.items,
    required this.overdueDateTime,
    required this.copyAndPaste,
    required this.qrCodeImage,
    required this.status,
    required this.total,
    this.createdDateTime,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  String toString() {
    return 'OrderModel{id: $id, createdDateTime: $createdDateTime, items: $items, overdueDateTime: $overdueDateTime, copyAndPaste: $copyAndPaste, qrCodeImage: $qrCodeImage, status: $status, total: $total}';
  }
}
