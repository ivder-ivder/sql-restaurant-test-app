import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:sql_test_task/logic/models/product.dart';

part 'order.g.dart';

@JsonSerializable(includeIfNull: false, createToJson: false)
class Order {
  Order({required this.id, required this.products});

  static Order fromJson(Map<String, dynamic> json) {
    return _$OrderFromJson(json);
  }

  int get price {
    int price = 0;
    for (Product product in products) {
      price += product.price * product.quantity;
    }

    return price;
  }

  Map<String, dynamic> toDbJson() => <String, dynamic>{
        'id': id,
        'products': jsonEncode(products.map((e) => e.toJson()).toList())
      };

  static Order fromDbJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      products: (jsonDecode(json['products']) as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final int id;
  final List<Product> products;
}
