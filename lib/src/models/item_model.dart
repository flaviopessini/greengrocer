import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  String id;

  @JsonKey(name: 'title')
  String itemName;

  String description;

  @JsonKey(name: 'picture')
  String imgUrl;

  String unit;

  double price;

  ItemModel({
    this.id = '',
    required this.itemName,
    required this.description,
    required this.imgUrl,
    required this.unit,
    required this.price,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'ItemModel{id: $id, itemName: $itemName, description: $description, imgUrl: $imgUrl, unit: $unit, price: $price}';
  }
}
