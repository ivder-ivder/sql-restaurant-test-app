import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(includeIfNull: false, createToJson: true)
class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  static Product fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  final int id;
  final String name;
  final int price;
  final int quantity;

  Product copyWith({
    int? quantity,
  }) {
    return Product(
        id: id, name: name, price: price, quantity: quantity ?? this.quantity);
  }

  @override
  List<Object?> get props => [id];
}
